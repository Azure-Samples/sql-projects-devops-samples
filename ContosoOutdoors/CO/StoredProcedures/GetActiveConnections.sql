CREATE PROCEDURE CO.GetActiveConnections

AS

SET NOCOUNT ON;
SELECT session_id
    , client_net_address
    , last_read
    , last_write
    , connect_time
FROM sys.dm_exec_connections;

RETURN 0