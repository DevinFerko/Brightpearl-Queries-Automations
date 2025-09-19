-- Will check that the raw data table and the constructed table will update at the same time
ELECT ord_id, ord_orderStatusName FROM dbo.tblOrder WHERE ord_id = 2191208;
SELECT [Order ID], [Status] FROM usr.Orders WHERE [Order ID] = 2191208;