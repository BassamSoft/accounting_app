SELECT
    account.*,
    COUNT(opertaions.opert_id) AS opert_count,
    SUM(
        CASE
            WHEN opertaions.opert_status = 0 THEN opertaions.opert_amount
            WHEN opertaions.opert_status = 1 THEN -opertaions.opert_amount
        END
    ) AS account_balance
FROM
    account
    LEFT JOIN opertaions ON account.account_id = opertaions.opert_account
GROUP BY account.account_id;