"""Custom processor for the hints kitten in kitty to detect shortlinks.

This is an extension for the kitty terminal that can be used with the
hints kitten (https://sw.kovidgoyal.net/kitty/kittens/hints) to detect
Google shortlinks then open them in your browser.
"""

import re

# Derived from devtools/search/linkifier/extlinks.go with slight modificiations.
AFTER_HOSTNAME_NO_PARENTHESIS = r'[\pL_!#-&*-;=?@^\|-~]*'
AFTER_HOSTNAME_WITH_PARENTHESIS = (
    '(?:'
    + AFTER_HOSTNAME_NO_PARENTHESIS
    + r'\('
    + AFTER_HOSTNAME_NO_PARENTHESIS
    + r'\))'
)
AFTER_HOSTNAME_SUFFIX = r'(?:[\pL_!#-&(-=?@^\|-~)]*[\pL\d#$%&*+/=@^_|~-])'
AFTER_HOSTNAME = (
    '(?:(?:'
    + AFTER_HOSTNAME_WITH_PARENTHESIS
    + '+'
    + AFTER_HOSTNAME_SUFFIX
    + '?)|'
    + AFTER_HOSTNAME_SUFFIX
    + ')'
)

GANPATI_NAME = r'[a-z\d](?:[a-z\d\-_]*[a-z\d])?'

LINK_RULES = [
    r'(b/\d+(?:#comment\d+)?)\b',
    r'(b/([\w-]+:[\w%-]+(?:[\w+-]+(:[\w%-]+)*)*)\b)',
    r'(b/hotlists/\d+)\b',
    r'((b|bug)/(?:issues/)?new(?:/|\?component=)(\d+(?:&template=\d+)?))\b',
    r'((b|bug)/savedsearches/(\d+))\b',
    r'(?:((b|bug)/components/(\d+))\b)',
    r'(cl/\d+)\b',
    r'(omg\d+)\b',
    r'(?:((launch|ariane)/(\d+)\b))',
    # r'^(?:((rapid|rapid-qa)/(' + AFTER_HOSTNAME + r')))',
    # r'^(?:((who|teams)/(' + AFTER_HOSTNAME + r')))',
    r'(?:((team)/(\d{5,})))',
    r'((?:ganpati2/|g2/)((?:user/|group/)'
    + GANPATI_NAME
    + r'(?:\.corp|\.prod)))',
    r'(google3/[^\s,]+)',
]

def mark(text, args, mark_text, extra_cli_args):
  """Find all potential shortlinks displayed in the current terminal.

  Args:
    text: The text currently on screen.
    args: Arguments passed to the kitten that are unused.
    mark_text: The class used to mark matching text.
    extra_cli_args: Any extra CLI args passed to the kitten.

  Yields:
    Each text identified as a shortlink.
  """

  del args, extra_cli_args  # Unused by the custom processor.
  regexp = '(' + '|'.join(LINK_RULES) + ')'
  for idx, m in enumerate(re.finditer(regexp, text)):
    start, end = m.span()
    yield mark_text(idx, start, end, text[start:end], {})


def handle_result(args, data, target_window_id, boss, extra_cli_args):
  """Open the selected mark as a URL in the browser.

  Args:
    args: Arbitrary args passed when the text is selected.
    data: The list of selected entries.
    target_window_id: The window that the mark was selected from.
    boss: The kitten API.
    extra_cli_args: Any extra CLI args passed to the kitten.
  """
  del args, target_window_id, extra_cli_args
  for shortlink in data['match']:
    boss.open_url(f'http://{shortlink}')
