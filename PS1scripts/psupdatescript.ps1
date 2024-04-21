# Define the server and database
$server = "DEVOPS-TEST"
$database = "AdventureWorks2019"

# SQL Server authentication credentials
$username = "Devops"
$password = "Devops"

# Path to your SQL script file
$sqlScriptPath = "C:\SQLScripts\updatescript.sql"

# Connection string with SQL Server authentication
$connectionString = "Server=$server;Database=$database;User ID=$username;Password=$password;"

# Execute the SQL script
Invoke-Sqlcmd -ServerInstance $server -Database $database -Username $username -Password $password -InputFile $sqlScriptPath -ConnectionTimeout 0
