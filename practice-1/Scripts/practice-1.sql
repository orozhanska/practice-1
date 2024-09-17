create database practice_1;

use practice_1;

create table clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    address VARCHAR(255),
    risk_level VARCHAR(20)
);

create table banks(
	bin_6 VARCHAR(6) PRIMARY KEY,
	bank_name VARCHAR (200),
	country VARCHAR (150)
);


create table accounts(
	iban VARCHAR(29) PRIMARY KEY,
	type_acc VARCHAR(10), -- "M" = merchant or "NM" - non-merchant
	client_id INT,
	bin_6 VARCHAR(6),
	balance INT,
	foreign key (client_id) references clients(client_id),
	foreign key (bin_6) references banks(bin_6)
);


drop table bank_fees;
create table bank_fees(
	fee_id INT AUTO_INCREMENT PRIMARY KEY,
	bin_6 VARCHAR(6),
	flat_fee_per_tr DECIMAL(3,2),
	foreign key (bin_6) references banks(bin_6)
);

create table transactions(
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
	iban_buyer VARCHAR(29),
	iban_merchant VARCHAR(29),
	amount INT,
	pot DATETIME DEFAULT NOW(),
	foreign key (iban_buyer) references accounts(iban),
	foreign key (iban_merchant) references accounts(iban)
);

create table tr_states(
	transaction_id INT,
	state VARCHAR(50),
	foreign key (transaction_id) references transactions(transaction_id);
)

INSERT INTO clients (first_name, last_name, address, risk_level) 
VALUES
	('John', 'Doe', '123 Elm St', 'Low'),
	('ФОП Olesia', 'Rozhanska', 'Beresteyka, KSE', 'Low' ),
	('Jane', 'Smith', '456 Oak St', 'Medium'),
	('ФОП Dariia', 'Hak', 'Obolon', 'high'),
	('Alice', 'Johnson', '789 Pine St', 'High'),
	('ФОП Liza', 'Dudu', 'Tarasa Shevchenka station', 'Medium'),
	('Bob', 'Brown', '321 Maple Ave', 'Low'),
	('Charlie', 'Black', '654 Cedar Dr', 'Medium'),
	('Oleksandr', 'Shevchenko', 'Prospekt Peremohy 45, Kyiv', 'Low'),
	('Yulia', 'Tymoshenko', 'Hreshchatyk 12, Kyiv', 'Medium'),
	('Andriy', 'Yarmolenko', 'Pryvokzalna 10, Lviv', 'High'),
	('Iryna', 'Koval', 'Shevchenko Blvd 23, Kharkiv', 'Low'),
	('Maksym', 'Lysenko', 'Derzhavinska 3, Dnipro', 'Medium'),
	('Emma', 'Johnson', '32 Baker St, London, UK', 'Low'),
	('Luca', 'Rossi', 'Via Roma 55, Milan, Italy', 'High'),
	('Sophie', 'Dubois', '10 Rue de Rivoli, Paris, France', 'Medium'),
	('Carlos', 'Martinez', 'Calle Gran Via 12, Madrid, Spain', 'Low'),
	('Wei', 'Li', '1 Nanjing Rd, Shanghai, China', 'High');
	
	
select * from clients
limit 100;

INSERT INTO banks (bin_6, bank_name, country) 
VALUES
	('410653', 'PrivatBank', 'Ukraine'),
	('537541', 'Monobank', 'Ukraine'),
	('537523', 'Monobank', 'Ukraine'),
	('222222', 'Barclays', 'UK'),
	('333333', 'Banca Intesa', 'Italy'),
	('444444', 'BNP Paribas', 'France'),
	('555555', 'Banco Santander', 'Spain'),
	('666666', 'Bank of China', 'China');
	
select * from banks
limit 100;

INSERT INTO accounts (iban, type_acc, client_id, bin_6, balance) 
VALUES
	('4106531234567890123456789', 'NM', 1, '410653', 5000),
	('5375419876543210987654321', 'M', 2, '537541', 350000),
	('5375231928374650192837465', 'NM', 3, '537523', 7000),
	('4106532345678901234567890', 'M', 4, '410653', 15000),
	('2222221029384756102938475', 'NM', 5, '222222', 12000),
	('5375415647382910564738291', 'M', 6, '537541', 159000),
	('2222226789012345678901234', 'NM', 7, '222222', 9000),
	('2222223456789012345678901', 'NM', 8, '222222', 8500),
	('4106539876543210123456789', 'NM', 9, '410653', 6000),
	('4106531234567890098765432', 'NM', 10, '410653', 20000),
	('4106531928374650192837465', 'NM', 11, '410653', 100000);
	
INSERT INTO accounts (iban, type_acc, client_id, bin_6, balance) 
VALUES
	('4106531234567890012345678', 'NM', 12, '410653', 18000),
	('5375414567890123456789123', 'M', 13, '537541', 220000),
	('2222223456789012345678902', 'NM', 14, '222222', 7500),
	('2222229876543210987654321', 'NM', 15, '222222', 12500),
	('4444445678901234567890123', 'M', 16, '444444', 14000),
	('5555558765432109876543210', 'NM', 17, '555555', 17000),
	('6666660123456789012345678', 'NM', 18, '666666', 23000);

	
INSERT INTO bank_fees (bin_6, flat_fee_per_tr)
VALUES
	('410653', 0.05),
	('537541', 0.06),
	('537523', 0.7),
	('222222', 0.6),
	('333333', 0.5),
	('444444', 0.45),
	('555555', 0.78),
	('666666', 0.2);
	
select * from transactions limit 200;

INSERT INTO transactions (iban_buyer, iban_merchant, amount)
VALUES
    ('4106531234567890123456789', '5375415647382910564738291', 1900),
    ('2222221029384756102938475', '5375414567890123456789123', 1000),
    ('2222223456789012345678902', '5375415647382910564738291', 4000),
    ('2222223456789012345678902', '5375415647382910564738291', 1600),
    ('6666660123456789012345678', '5375415647382910564738291', 1200),
    
    ('4106531234567890012345678', '4106532345678901234567890', 1500),
    ('5375414567890123456789123', '4106532345678901234567890', 1200),
    ('5375415647382910564738291', '4106532345678901234567890', 700),
    ('2222223456789012345678902', '5375414567890123456789123', 2500),
    ('6666660123456789012345678', '4106532345678901234567890', 1000),
    
    ('5375231928374650192837465', '5375419876543210987654321', 500),
    ('4106532345678901234567890', '5375419876543210987654321', 1500),
    ('4106531234567890123456789', '5375414567890123456789123', 300),
    ('6666660123456789012345678', '5375419876543210987654321', 2000),
    ('4106532345678901234567890', '5375419876543210987654321', 800);
    
INSERT INTO tr_states (transaction_id, state) 
VALUES
	(46, 'completed'),
	(47, 'completed'),
	(48, 'rejected'),
	(49, 'completed'),
	(50, 'failed'),
	(51, 'completed'),
	(52, 'completed'),
	(53, 'completed'),
	(54, 'failed'),
	(55, 'approved'),
	(56, 'pending'),
	(57, 'completed'),
	(58, 'failed'),
	(59, 'completed'),
	(60, 'rejected');

select * from transactions
limit 100;

create table revenues as
(
with client_account as
(
	select cl.client_id, concat(cl.first_name, ' ', cl.last_name) as name, acc.iban, acc.type_acc, acc.bin_6, acc.balance
	from clients as cl
	left join accounts as acc
	on cl.client_id = acc.client_id
),
merchant_acc AS 
(
	select *
	from client_account 
	where type_acc = "M"
),
merchant_trans AS 
(
	select *
	from merchant_acc
	join transactions
	on merchant_acc.iban = transactions.iban_merchant
	
),
merchant_fees as
(
	select m.client_id,m.name, m.iban, m.bin_6, m.amount, f.flat_fee_per_tr
	from merchant_trans as m
	left join bank_fees as f
	on m.bin_6 = f.bin_6
),

m_revenue as
(
	select iban, sum(amount) as revenue
	from merchant_fees
	group by iban
),
fee_rev AS 
(
	SELECT distinct f.client_id, f.name, f.iban, f.flat_fee_per_tr, r.revenue,
		((1- f.flat_fee_per_tr) * r.revenue) as total 
	from m_revenue as r
	join merchant_fees as f
	on r.iban = f.iban
	order by total DESC
)

select name, total from fee_rev
limit 100
);

select * from revenues
limit 100;

-- 
create table expenditures as
(
with client_account as
(
	select cl.client_id, concat(cl.first_name, ' ', cl.last_name) as name, acc.iban, acc.type_acc, acc.bin_6, acc.balance
	from clients as cl
	left join accounts as acc
	on cl.client_id = acc.client_id
),
join_bank AS 
(
	select cl.client_id, cl.name, cl.iban, cl.type_acc, cl.bin_6, cl.balance, b.country
	from client_account as cl
	left join banks as b
	on cl.bin_6 = b.bin_6
	where cl.type_acc = 'NM'
),
join_trans AS 
(
	SELECT b.client_id, coalesce(b.name, "NA") as name, t.iban_buyer, b.bin_6, coalesce(b.country, "NA") as country, (t.amount*(-1)) as expenditures, t.transaction_id
	from join_bank as b
	right join transactions as t
	on b.iban = t.iban_buyer
),
join_states AS 
(
	SELECT t.name, t.iban_buyer, t.bin_6, t.country, t.expenditures, t.transaction_id, s.state
	from join_trans as t
	left join tr_states as s
	on t.transaction_id = s.transaction_id
),

statistics as
(
	SELECT name, sum(expenditures) as total
	from join_states
	where state != "rejected"
	group by name
	order by total ASC
)

select * from statistics limit 100
);
create table totals as
(
	select * from expenditures 
	union 
	select * from revenues
);

select * from totals limit 100;

