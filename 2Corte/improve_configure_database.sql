-- Check existing databases
SELECT datname FROM pg_database WHERE datistemplate = false;

-- Check current database
SELECT current_database();

-- Check current user
SELECT current_user;

-- Check server version
SELECT version();

-- Create schema if not exists
DO $$
BEGIN
    IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'sr10_public') THEN
        CREATE SCHEMA sr10_public;
    END IF;
END $$;

-- Create table with enhanced definition
CREATE TABLE IF NOT EXISTS sr10_public.tbr10_contacts (
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name VARCHAR(80) NOT NULL,
    email VARCHAR(120),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create users with more secure password generation
DO $$
BEGIN
    IF NOT EXISTS (SELECT usename FROM pg_user WHERE usename = 'r10_user_schema') THEN
        CREATE USER r10_user_schema WITH PASSWORD 'securePassword123!';
    END IF;

    IF NOT EXISTS (SELECT usename FROM pg_user WHERE usename = 'r10_user_table') THEN
        CREATE USER r10_user_table WITH PASSWORD 'secureTableAccess456!';
    END IF;
END $$;

-- Grant schema permissions
GRANT USAGE ON SCHEMA sr10_public TO r10_user_schema;
GRANT CREATE ON SCHEMA sr10_public TO r10_user_schema;
GRANT USAGE ON SCHEMA sr10_public TO r10_user_table;

-- Grant table permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON sr10_public.tbr10_contacts TO r10_user_table;
GRANT ALL PRIVILEGES ON sr10_public.tbr10_contacts TO r10_user_schema;

-- Optional: Grant permissions on public schema
GRANT USAGE ON SCHEMA public TO r10_user_schema;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO r10_user_schema;

-- Add some logging and audit capabilities
ALTER TABLE sr10_public.tbr10_contacts
    ADD COLUMN IF NOT EXISTS created_by VARCHAR(50),
    ADD COLUMN IF NOT EXISTS last_modified_by VARCHAR(50);

-- Create an audit trigger function
CREATE OR REPLACE FUNCTION sr10_public.update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic updated_at timestamp
CREATE TRIGGER update_tbr10_contacts_modtime
BEFORE UPDATE ON sr10_public.tbr10_contacts
FOR EACH ROW
EXECUTE FUNCTION sr10_public.update_modified_column();

-- Final verification queries
SELECT
    schemaname,
    tablename,
    tableowner
FROM pg_tables
WHERE schemaname = 'sr10_public';

SELECT
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.table_privileges
WHERE table_schema = 'sr10_public';