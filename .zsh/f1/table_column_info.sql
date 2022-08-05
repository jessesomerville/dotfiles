CREATE TEMP FUNCTION FormatType(repeated BOOL, type_enum STRING)
RETURNS STRING
AS (
  IF(
    repeated,
    FORMAT('%s[]', REGEXP_EXTRACT(type_enum, r'TYPE_(.*)')),
    REGEXP_EXTRACT(type_enum, r'TYPE_(.*)'))
);

WITH
  TableSpec AS (
    SELECT entry_spec.type_spec.table_spec.table_schema.column AS columns
    FROM datahub.entries.latest
    WHERE
      type = 'TABLE'
      AND id.dataset_id.dataset_local_id = "${TABLE_NS}"
      AND id.entry_local_id = "${TABLE_NAME}"
  )
SELECT
  col.name,
  FormatType(col.is_repeated, CAST(col.type AS STRING)) AS col_type,
  col.description,
FROM TableSpec AS D, D.columns AS col;

