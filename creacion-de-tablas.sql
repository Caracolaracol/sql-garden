CREATE DATABASE gardens;

USE gardens;

CREATE TABLE IF NOT EXISTS gardens.organizations (
	organization_id INT NOT NULL AUTO_INCREMENT,
    organization_name VARCHAR(150),
    organization_address VARCHAR(50),
    organization_city VARCHAR(50),
    organization_country VARCHAR(50),
    organization_size INT,
    PRIMARY KEY (organization_id)
);

CREATE TABLE IF NOT EXISTS gardens.organization_type (
	type_id INT NOT NULL AUTO_INCREMENT,
    organization_id INT,
    type VARCHAR(50),
    PRIMARY KEY (type_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id)
);

CREATE TABLE IF NOT EXISTS gardens.sectors (
	sector_id INT NOT NULL AUTO_INCREMENT,
    sector_name VARCHAR(50),
    sector_size INT,
    organization_id INT,
    PRIMARY KEY (sector_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id)
);

CREATE TABLE IF NOT EXISTS gardens.greenhouses (
	greenhouse_id INT NOT NULL AUTO_INCREMENT,
	organization_id INT,
	greenhouse_size INT,
	greenhouse_name VARCHAR(120),
	sector_id INT,
	PRIMARY KEY (greenhouse_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
	FOREIGN KEY (sector_id) REFERENCES sectors(sector_id)
);

CREATE TABLE IF NOT EXISTS gardens.plots (
	plot_id INT NOT NULL AUTO_INCREMENT,
    plot_name VARCHAR(120),
    organization_id INT,
    sector_id INT,
    plot_size INT,
    PRIMARY KEY (plot_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
    FOREIGN KEY (sector_id) REFERENCES sectors(sector_id)
);

CREATE TABLE IF NOT EXISTS gardens.notable_species (
	plant_id INT NOT NULL AUTO_INCREMENT,
    plant_name VARCHAR(150),
    plant_scientific_name VARCHAR(150),
    plant_variety VARCHAR(150),
    plant_age VARCHAR(150),
    organization_id INT,
    plot_id INT,
    sector_id INT,
    PRIMARY KEY (plant_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id),
    FOREIGN KEY (sector_id) REFERENCES sectors(sector_id)
);

CREATE TABLE IF NOT EXISTS gardens.members (
	member_id INT NOT NULL AUTO_INCREMENT,
    member_name VARCHAR(100),
    member_lastname VARCHAR(100),
    member_type VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE IF NOT EXISTS gardens.members_contact (
	contact_id INT NOT NULL AUTO_INCREMENT,
    phone VARCHAR(100),
    email VARCHAR(120),
    member_id INT,
    PRIMARY KEY (contact_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE IF NOT EXISTS gardens.employees (
	employee_id INT NOT NULL AUTO_INCREMENT,
    plot_id INT,
    member_id INT,
    employee_position VARCHAR(120),
    PRIMARY KEY (employee_id),
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE IF NOT EXISTS gardens.volunteers (
	volunteer_id INT NOT NULL AUTO_INCREMENT,
    ocupation VARCHAR(40),
    volunteer_date VARCHAR(120),
    plot_id INT,
    member_id INT,
    PRIMARY KEY (volunteer_id),
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE IF NOT EXISTS gardens.events (
	event_id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(200),
    event_description VARCHAR(300),
    event_location VARCHAR(150),
    event_date DATE,
    event_duration TIME,
    organization_id INT,
    PRIMARY KEY (event_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id)
);

CREATE TABLE IF NOT EXISTS gardens.resources (
	resource_id INT NOT NULL AUTO_INCREMENT,
    resource_name VARCHAR(120),
    resource_description VARCHAR(120),
    resource_quantity INT,
    measurement_unit VARCHAR(100),
    availability TINYINT,
    organization_id INT,
    sector_id INT,
    PRIMARY KEY (resource_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
	FOREIGN KEY (sector_id) REFERENCES sectors(sector_id)
);

CREATE TABLE IF NOT EXISTS gardens.metrics_anayltics (
	metric_id INT NOT NULL AUTO_INCREMENT,
    metric_name VARCHAR(100),
    metric_type VARCHAR(70),
    metric_description VARCHAR(300),
    metric_measurement_unitss VARCHAR(70),
    measurement_date DATE,
    metric_value INT,
    organization_id INT,
    PRIMARY KEY (metric_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id)
);

CREATE TABLE IF NOT EXISTS inkind_donations (
	item_id INT NOT NULL AUTO_INCREMENT,
    item_quantity DECIMAL,
    item_unit VARCHAR (100),
    PRIMARY KEY (item_id)
);

CREATE TABLE IF NOT EXISTS financial_donations (
	amount_id INT NOT NULL AUTO_INCREMENT,
    amount DECIMAL(11,2),
    currency VARCHAR(50),
    PRIMARY KEY (amount_id)
);

CREATE TABLE IF NOT EXISTS gardens.donations (
	donation_id INT NOT NULL AUTO_INCREMENT,
    donor_name VARCHAR(100),
    contact VARCHAR(100),
    donation_date DATE,
    donation_type VARCHAR(100),
    donation_description VARCHAR(250),
    organization_id INT,
    amount_id INT,
    item_id int,
    PRIMARY KEY (donation_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
    FOREIGN KEY (amount_id) REFERENCES financial_donations(amount_id),
    FOREIGN KEY (item_id) REFERENCES inkind_donations(item_id)
);

CREATE TABLE IF NOT EXISTS gardens.products_category (
	category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(120),
    PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS gardens.products (
	product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(120),
    category_id INT,
    price INT,
    product_stock INT,
    product_origin VARCHAR(200),
    organization_id INT,
    PRIMARY KEY (product_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
    FOREIGN KEY (category_id) REFERENCES products_category(category_id)
);

CREATE TABLE IF NOT EXISTS gardens.sales (
	sale_id INT NOT NULL AUTO_INCREMENT,
    organization_id INT,
    sale_date DATE,
    total_amount INT,
    PRIMARY KEY (sale_id),
	FOREIGN KEY (organization_id) REFERENCES organizations(organization_id)
);

CREATE TABLE IF NOT EXISTS gardens.sale_items (
	sale_item_id INT NOT NULL AUTO_INCREMENT,
    sale_id INT,
    product_id INT,
    quantity_sold INT,
    unit_price INT,
    subtotal INT,
    PRIMARY KEY (sale_item_id),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);







