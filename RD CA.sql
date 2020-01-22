CREATE TABLE banks
(bank_id INT(3)
AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
website VARCHAR(30) NOT NULL,
UNIQUE(name,website)
);

CREATE TABLE savings_accounts
(savings_id INT(3)
AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
total_rate DECIMAL(3,2) NOT NULL,
guarantee BOOLEAN NOT NULL,
sponsored BOOLEAN NOT NULL,
online_use BOOLEAN NOT NULL,
account_type VARCHAR(25) NOT NULL,
1st_bonus BOOLEAN,
insurance_cost INT(4),
age_limit INT(3),
trim_payment BOOLEAN,
max_deposit INT(4),
linked_bk BOOLEAN,
duration INT(3),
insurance INT(4),
maxi_deposit INT(5),
bank_id INT(3) NOT NULL,
FOREIGN KEY fk_bank(bank_id) REFERENCES banks(bank_id)
ON UPDATE CASCADE
ON DELETE RESTRICT
);

ALTER TABLE savings_accounts
ADD CONSTRAINT ck_account_type_regulated
CHECK (
    CASE
        WHEN account_type = "Regulated"
        THEN
         CASE
WHEN 1st_bonus IS NOT NULL AND insurance_cost IS NOT NULL AND age_limit IS NOT NULL
                THEN 1
                ELSE 0
            END

WHEN account_type = "Non-Regulated"
        THEN
         CASE
                WHEN trim_payment IS NOT NULL AND max_deposit IS NOT NULL AND linked_bk IS NOT NULL
                THEN 1
                ELSE 0
END

WHEN account_type = "Savings-Plans"
	THEN
	 CASE
		WHEN duration IS NOT NULL AND maxi_deposit IS NOT NULL AND maxi_deposit IS NOT NULL
		THEN 1
		ELSE 0
	
	              END
        ELSE 0
    END = 1
);

# The goal of the alter table is to add a check/integrity constraint in order to check when we enter information in each account type,
# that each 3 attributes are not null. Which means if we try and enter a null value in an attribute in an account type that must be populated,
# it will give us an error. I used the case statement which is similar to the if statement in order to add constraints that mustn’t be violated.
# Then = 1 means success and that all the necessary attributes have been entered, Else = 0 means that the constraints have been violated
# and that will result in an error. The final Else = 0 means it will give us an error if no values have been entered at all.
# And End = 1 means success and that all required values have been entered.


CREATE TABLE reductions
(reduction_id INT(3) NOT NULL
AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
type VARCHAR(20) NOT NULL,
description VARCHAR(50) NOT NULL,
amount INT(2) NOT NULL
);

CREATE TABLE extentions
(extention_id INT(3) NOT NULL
AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
type VARCHAR(20) NOT NULL,
description VARCHAR(50) NOT NULL,
amount INT(2) NOT NULL
);



CREATE TABLE insurance_accounts
(insurance_id INT(3)
AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
247_assistance BOOLEAN NOT NULL,
sponsored BOOLEAN NOT NULL,
harm_3rd BOOLEAN,
acc_assitance BOOLEAN,
theft_bg BOOLEAN,
hail_storm BOOLEAN,
coll_anim BOOLEAN,
propper_dmg BOOLEAN,
vandalism BOOLEAN,
theft_allowance BOOLEAN,
account_type VARCHAR(50) NOT NULL,
bank_id INT(3) NOT NULL,
FOREIGN KEY fk_bank(bank_id) REFERENCES banks(bank_id)
ON UPDATE CASCADE
ON DELETE RESTRICT,
reduction_id INT(3) NOT NULL,
FOREIGN KEY fk_reduction(reduction_id) REFERENCES reductions(reduction_id)
ON UPDATE CASCADE
ON DELETE RESTRICT,
extention_id INT(3),
FOREIGN KEY fk_extention(extention_id) REFERENCES extentions(extention_id)
ON UPDATE CASCADE
ON DELETE RESTRICT
);




INSERT INTO banks
VALUES
(1, 'Santander', 'www.santander.be'),
(2, 'CPH Banque', 'www.cph.be'),
(3, 'NIBC Direct', 'www.nibcdirect.be'),
(4, 'Izola Bank', 'www.izolabank.com'),
(5, 'Beobank', 'www.beobank.be'),
(6, 'Triodos', 'www.triodos.be'),
(7, 'AXA', 'www.axa.be'),
(8, 'ING', 'www.ing.be'),
(9, 'Allianz', 'www.allianz.com')
;

INSERT INTO savings_accounts
(savings_id, name, total_rate, guarantee, sponsored, online_use,  account_type, 1st_bonus, insurance_cost, age_limit, bank_id)
VALUES
(1, 'Vision +', 0.8, TRUE, FALSE, TRUE, 'Regulated', TRUE, 0, 0, 1),
(2, 'Carnet dépôt', 0.6, TRUE, FALSE, TRUE, 'Regulated', TRUE, 5, 25, 2)
;

INSERT INTO savings_accounts
(savings_id, name, total_rate, guarantee, sponsored, online_use, account_type, trim_payment, max_deposit, linked_bk, bank_id)
VALUES
(3, 'Compte flex', 0.42, TRUE, FALSE, TRUE, 'Non-regulated', TRUE, 0, FALSE, 3),
(4, 'Saver account', 0.42, TRUE, TRUE, TRUE, 'Non-regulated', FALSE, 500, TRUE, 4)
;

INSERT INTO savings_accounts
(savings_id, name, total_rate, guarantee, sponsored, online_use, account_type, duration, insurance, maxi_deposit, bank_id)
VALUES
(5, 'Epargne step up', 0.36, TRUE, TRUE, FALSE, 'Savings-Plans', 15, 15, 750, 5),
(6, 'Epargne mensuelle', 0.31, TRUE, FALSE, TRUE, 'Savings-Plans', 20, 10, 500, 6)
;

INSERT INTO reductions
(reduction_id, name, type, description, amount)
VALUES
(1, 'Milage reduction', 'Milage', 'Applicable for less than 15k km/year', 9),
(2, 'DA system', 'Equipment', 'Applicable if the system is present', 10)
;

INSERT INTO extentions
(extention_id, name, type, description, amount)
VALUES
(1, 'Driver insurance', 'Insurance', 'Insurance to driving related accidents', 3),
(2, 'Legal protection', 'Legal', 'Legal assitance in court', 2),
(3, 'European assitance', 'Assitance', 'Assitance in Europe', 2)
;


INSERT INTO insurance_accounts
(insurance_id, name, 247_assistance, sponsored, account_type, harm_3rd, acc_assitance, bank_id, reduction_id, extention_id)
VALUES
(1, 'Civil liability AXA', TRUE, FALSE, 'Civil liability', TRUE, TRUE, 7, 1, 2),
(2, 'Civil liability ING', TRUE, TRUE, 'Civil liability', TRUE, TRUE, 8, 2, 2)
;

INSERT INTO insurance_accounts
(insurance_id, name, 247_assistance, sponsored, account_type, harm_3rd, acc_assitance, theft_bg, hail_storm, coll_anim, bank_id, reduction_id, extention_id)
VALUES
(3, 'Mini omnium Allianz', TRUE, FALSE, 'Mini omnium', TRUE, TRUE, TRUE, TRUE, TRUE, 9, 1, 1),
(4, 'Mini omnium ING', TRUE, FALSE, 'Mini omnium', TRUE, TRUE, TRUE, TRUE, TRUE, 8, 1, 1)
;

INSERT INTO insurance_accounts
(insurance_id, name, 247_assistance, sponsored, account_type, harm_3rd, acc_assitance, theft_bg, hail_storm, coll_anim, propper_dmg, vandalism, theft_allowance, bank_id, reduction_id, extention_id)
VALUES
(5, 'Omnium AXA', TRUE, FALSE, 'Omnium', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 7, 1, 1),
(6, 'Omnium ING', TRUE, TRUE, 'Omnium', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 8, 2, 3)
;



# Queries

# As explained before in the business description, the goal of this comparison website is to offer comparisons of different products to the user.
# Therefore, we would imagine that it is the user that performs the queries and then a search engine (or any other technology) would be linked to our database,
# then it would display the results in the form of a table in the website.

# 1) A user is looking for a savings account that has more than 0.4% total rate, with no insurance cost or age limit.
# Note: I have used an IF statement in order to convert the boolean values into 'Yes' or 'No' for better visualization.

SELECT name AS 'Account name', CONCAT(total_rate, "%") AS 'Total rate', IF(guarantee=1, 'Yes', 'No') AS 'Guarantee', IF(1st_bonus=1, 'Yes', 'No') AS '1st Bonus',
IF(insurance_cost=1, 'Yes', 'No') AS 'Insurance cost', age_limit
from savings_accounts
where total_rate>0.4 and insurance_cost=0 and age_limit=0
;

# 2) A user is looking for the average total rates for savings accounts by account type.
# Note: I have used the FORMAT function in order to limit the average total rate to 2 decimal places.

SELECT account_type AS 'Account type', FORMAT(AVG(total_rate),2) AS 'Total rate'
FROM savings_accounts
GROUP BY account_type
;



# 3) A user is looking for total rates by each savings account with their bank name displayed

SELECT sa.name AS 'Account name', sa.total_rate AS 'Total rate', ba.name AS 'Bank'
FROM savings_accounts sa
	INNER JOIN
		banks ba on sa.bank_id = ba.bank_id
        ;


# 4) A user is looking for insurance accounts with account’s name, bank, reduction & extention displayed.

SELECT ia.name AS 'Account name', ba.name AS 'Bank', red.name AS 'Reduction', ext.name AS 'Extention'
FROM insurance_accounts ia
	INNER JOIN
    banks ba on ia.bank_id = ba.bank_id
    INNER JOIN
    reductions red on ia.reduction_id = red.reduction_id
    INNER JOIN
    extentions ext on ia.extention_id = ext.extention_id
    ;

# 5) A user is looking for a Civil Liability insurance account that has the driving assistance system reduction and a legal assistance extention

SELECT ia.name AS 'Account name', ba.name AS 'Bank', red.name AS 'Reduction', ext.name AS 'Extention'
FROM insurance_accounts ia
	INNER JOIN
    banks ba on ia.bank_id = ba.bank_id
    INNER JOIN
    reductions red on ia.reduction_id = red.reduction_id
    INNER JOIN
    extentions ext on ia.extention_id = ext.extention_id
    WHERE ia.account_type='Civil liability' AND red.name='DA system' AND ext.name='Legal protection'
    ;

