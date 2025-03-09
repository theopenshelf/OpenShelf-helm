-- Add status column to users table
ALTER TABLE users
    ADD COLUMN status varchar(255) NOT NULL DEFAULT 'WAITING_FOR_EMAIL' CHECK (status IN ('WAITING_FOR_EMAIL', 'ACTIVE', 'INACTIVE'));

-- Update existing users to ACTIVE if they're already email verified
UPDATE users 
    SET status = 'ACTIVE' 
    WHERE is_email_verified = true;