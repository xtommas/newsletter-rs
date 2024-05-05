-- Transaction to make status NOT NULL in the subscriptinos table
-- The transaction makes sure that everything succeeds and, if not,
-- it rolls the changes back
BEGIN;
    -- Make old entries have the status 'confirmed'
    UPDATE subscriptions
        SET status = 'confirmed'
        WHERE status IS NULL;
    -- Make status mandatory
    ALTER TABLE subscriptions ALTER COLUMN status SET NOT NULL;
COMMIT;
