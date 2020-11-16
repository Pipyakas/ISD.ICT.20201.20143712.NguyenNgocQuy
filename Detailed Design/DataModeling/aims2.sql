-- we don't know how to generate root <with-no-name> (class Root) :(
create table Card
(
	id INTEGER not null
		primary key autoincrement,
	cardCode VARCHAR
(15) not null,
	owner VARCHAR
(45) not null,
	cvvCode VARCHAR
(3) not null,
	dateExpired VARCHAR
(4) not null
);

create table DeleveryInfo
(
	id INTEGER not null
		primary key autoincrement,
	name VARCHAR
(45),
	province VARCHAR
(45),
	instructions VARCHAR
(200),
	address VARCHAR
(100)
);

create table Media
(
	id INTEGER not null
		primary key autoincrement,
	category VARCHAR
(45) not null,
	price INTEGER not null,
	quantity INTEGER not null,
	title VARCHAR
(45) not null,
	value INTEGER not null,
	imageUrl VARCHAR
(45) not null,
	rush bool
);

create table Book
(
    id INTEGER not null
        primary key
        constraint fk_Book_Media1
			references Media,
    author VARCHAR(45) not null,
    coverType VARCHAR(45) not null,
    publisher VARCHAR(45) not null,
    publishDate DATETIME not null,
    numOfPages INTEGER not null,
    language VARCHAR(45) not null,
    bookCategory VARCHAR(45) not null
);

create table CD
(
    id INTEGER not null
        primary key
        constraint fk_CD_Media1
			references Media,
    artist VARCHAR(45) not null,
    recordLabel VARCHAR(45) not null,
    musicType VARCHAR(45) not null,
    releasedDate DATE
);

create table DVD
(
    id INTEGER not null
        primary key
        constraint fk_DVD_Media1
			references Media,
    discType VARCHAR(45) not null,
    director VARCHAR(45) not null,
    runtime INTEGER not null,
    studio VARCHAR(45) not null,
    subtitle VARCHAR(45) not null,
    releasedDate DATETIME
);

create table "Order"
(
    id INTEGER not null,
    shippingFees VARCHAR(45),
    deleveryInfoId INTEGER not null
        constraint fk_Order_DeleveryInfo1
			references DeleveryInfo,
    primary key (id, deleveryInfoId)
);

create table Invoice
(
    id INTEGER not null
        primary key,
    totalAmount INTEGER not null,
    orderId INTEGER not null
        constraint fk_Invoice_Order1
			references "Order" (id)
);

create index "Invoice.fk_Invoice_Order1_idx"
	on Invoice (orderId);

create index "Order.fk_Order_DeleveryInfo1_idx"
	on "Order" (deleveryInfoId);

create table OrderMedia
(
    orderID INTEGER not null
        constraint fk_ordermedia_order
			references "Order" (id),
    price INTEGER not null,
    quantity INTEGER not null,
    mediaId INTEGER not null
        constraint fk_OrderMedia_Media1
			references Media,
    primary key (orderID, mediaId)
);

create index "OrderMedia.fk_OrderMedia_Media1_idx"
	on OrderMedia (mediaId);

create index "OrderMedia.fk_ordermedia_order_idx"
	on OrderMedia (orderID);

create table OrderMediaRush
(
    orderID int not null
        constraint OrderMediaRush_Order_id_fk
			references "Order" (id),
    mediaID int not null
        references Media,
    quantity int not null,
    price int not null,
    constraint OrderMediaRush_pk
		primary key (mediaID, orderID)
);

create table PaymentTransaction
(
    id INTEGER not null,
    createAt DATETIME not null,
    content VARCHAR(45) not null,
    method VARCHAR(45),
    cardId INTEGER not null
        constraint fk_PaymentTransaction_Card1
			references Card,
    invoiceId INTEGER not null
        constraint fk_PaymentTransaction_Invoice1
			references Invoice,
    primary key (id, cardId, invoiceId)
);

create index "PaymentTransaction.fk_PaymentTransaction_Card1_idx"
	on PaymentTransaction (cardId);

create index "PaymentTransaction.fk_PaymentTransaction_Invoice1_idx"
	on PaymentTransaction (invoiceId);

