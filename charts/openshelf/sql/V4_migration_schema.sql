
ALTER TABLE "notifications"
ADD COLUMN "user_id" UUID NOT NULL;

-- If you need to add a foreign key constraint to the users table:
ALTER TABLE "notifications"
ADD CONSTRAINT "fk_notifications_user" 
FOREIGN KEY ("user_id") 
REFERENCES "users" ("id");

CREATE TABLE settings (
    key VARCHAR(255) PRIMARY KEY,
    value TEXT NOT NULL,
    is_public BOOLEAN NOT NULL DEFAULT false
);

-- Insert some initial settings
INSERT INTO settings (key, value, is_public) 
VALUES ('registration.enabled', 'true', true);

-- Add community_id column to items table
ALTER TABLE "items"
    ADD COLUMN "community_id" UUID;

-- Add foreign key constraint
ALTER TABLE "items"
    ADD CONSTRAINT "fk_items_community" 
    FOREIGN KEY ("community_id") 
    REFERENCES "communities" ("id");

-- Update existing items to set community_id based on their library's community
UPDATE "items" i
SET "community_id" = l."community_id"
FROM "libraries" l
WHERE i."library_id" = l."id";