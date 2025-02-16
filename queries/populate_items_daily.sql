CREATE OR REPLACE PROCEDURE `mlcase-hassakura.case1.populate_items_daily`() BEGIN

  MERGE `mlcase-hassakura.case1.items_daily` AS items_daily USING (
    SELECT
        item_id,
        CURRENT_DATE() AS snapshot_date,
        price,
        status,
        CURRENT_TIMESTAMP() AS updated_at
      FROM `mlcase-hassakura.case1.items`
  ) AS items
  ON items_daily.item_id = items.item_id AND items_daily.snapshot_date = items.snapshot_date
  
  WHEN MATCHED THEN UPDATE SET
      price = items.price,
      status = items.status,
      updated_at = items.updated_at
  
  WHEN NOT MATCHED THEN
    INSERT (item_id, snapshot_date, price, status, updated_at)
    VALUES (
      items.item_id, items.snapshot_date, items.price, items.status, items.updated_at
    );
END;