CREATE TABLE bosses
(
  boss_id         UUID        NOT NULL,
  name            VARCHAR(32) NOT NULL,
  last_name       VARCHAR(32) NOT NULL,
  patronymic_name VARCHAR(32) NOT NULL,
  PRIMARY KEY (boss_id)
);

CREATE TABLE employees
(
  employee_id      UUID        NOT NULL,
  family_status_id UUID        NOT NULL,
  health_status_id UUID        NOT NULL,
  name             VARCHAR(32) NOT NULL,
  birth_date       DATE        NOT NULL,
  bank_details     CHAR(20)    NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employees_movement
(
  employee_id UUID      NOT NULL,
  entered_at  TIMESTAMP NOT NULL
);

CREATE TABLE employees_passport
(
  employee_id UUID         NOT NULL,
  series      CHAR(4)      NOT NULL,
  number      CHAR(6)      NOT NULL,
  issue_place VARCHAR(128) NOT NULL,
  issue_date  DATE         NOT NULL,
  issued_by   VARCHAR(128) NOT NULL
);

CREATE TABLE family_statuses
(
  family_status_id UUID        NOT NULL,
  status_name      VARCHAR(32) NOT NULL,
  PRIMARY KEY (family_status_id)
);

CREATE TABLE health_statuses
(
  health_status_id UUID        NOT NULL,
  status_name      VARCHAR(32) NOT NULL,
  PRIMARY KEY (health_status_id)
);

CREATE TABLE manager_positions
(
  manager_position_id UUID        NOT NULL,
  position_name       VARCHAR(16) NOT NULL,
  PRIMARY KEY (manager_position_id)
);

CREATE TABLE managers
(
  manager_id          UUID         NOT NULL,
  manager_position_id UUID         NOT NULL,
  name                VARCHAR(32)  NOT NULL,
  phone               CHAR(12)     NOT NULL,
  email               VARCHAR(344) NOT NULL,
  PRIMARY KEY (manager_id)
);

CREATE TABLE material_releases
(
  material_id UUID      NOT NULL,
  product_id  UUID      NOT NULL,
  count       INT4      NOT NULL,
  released_at TIMESTAMP NOT NULL
);

CREATE TABLE material_types
(
  material_type_id UUID        NOT NULL,
  type_name        VARCHAR(64) NOT NULL,
  PRIMARY KEY (material_type_id)
);

CREATE TABLE materials
(
  material_id          UUID           NOT NULL,
  material_type_id     UUID           NOT NULL,
  unit_id              UUID           NOT NULL,
  name                 VARCHAR(256)   NOT NULL,
  quantity_per_package INT4          ,
  description          TEXT          ,
  image_url            VARCHAR(512)  ,
  cost                 DECIMAL(10, 2),
  minimum_quantity     INT4          ,
  PRIMARY KEY (material_id)
);

CREATE TABLE materials_receipts
(
  material_id UUID      NOT NULL,
  count       INT4      NOT NULL,
  received_at TIMESTAMP NOT NULL
);

CREATE TABLE materials_reservations
(
  material_id UUID      NOT NULL,
  product_id  UUID      NOT NULL,
  count       INT4      NOT NULL,
  reserved_at TIMESTAMP NOT NULL
);

CREATE TABLE materials_writeoff
(
  material_id   UUID      NOT NULL,
  product_id    UUID      NOT NULL,
  count         INT4      NOT NULL,
  writtenoff_at TIMESTAMP NOT NULL
);

CREATE TABLE order_details
(
  order_detail_id UUID      NOT NULL,
  order_id        UUID      NOT NULL,
  product_id      UUID      NOT NULL,
  quantity        INT4      NOT NULL,
  producted_at    TIMESTAMP NOT NULL,
  delivered_at    TIMESTAMP,
  PRIMARY KEY (order_detail_id)
);

CREATE TABLE order_statuses
(
  order_status_id UUID        NOT NULL,
  status_name     VARCHAR(16) NOT NULL,
  PRIMARY KEY (order_status_id)
);

CREATE TABLE orders
(
  order_id        UUID      NOT NULL,
  partner_id      UUID      NOT NULL,
  order_status_id UUID      NOT NULL,
  ordered_at      TIMESTAMP NOT NULL,
  PRIMARY KEY (order_id)
);

CREATE TABLE partner_sales_history
(
  sales_history_id UUID      NOT NULL,
  partner_id       UUID      NOT NULL,
  product_id       UUID      NOT NULL,
  sold_at          TIMESTAMP NOT NULL,
  sales_volume     INT4      NOT NULL,
  PRIMARY KEY (sales_history_id)
);

CREATE TABLE partner_sales_locations
(
  sales_location_id UUID         NOT NULL,
  partner_id        UUID         NOT NULL,
  location          VARCHAR(128) NOT NULL,
  PRIMARY KEY (sales_location_id)
);

CREATE TABLE partner_types
(
  partner_type_id UUID         NOT NULL,
  type_name       VARCHAR(128) NOT NULL,
  PRIMARY KEY (partner_type_id)
);

CREATE TABLE partners
(
  partner_id      UUID         NOT NULL,
  boss_id         UUID         NOT NULL,
  partner_type_id UUID         NOT NULL,
  company_name    VARCHAR(256) NOT NULL,
  address         VARCHAR(256) NOT NULL,
  inn             CHAR(12)     NOT NULL,
  phone           CHAR(12)     NOT NULL,
  email           VARCHAR(344) NOT NULL,
  logo_url        VARCHAR(512) NOT NULL,
  PRIMARY KEY (partner_id)
);

CREATE TABLE partners_products_price_history
(
  partner_id UUID           NOT NULL,
  product_id UUID           NOT NULL,
  price      DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP      NOT NULL
);

CREATE TABLE partners_rating
(
  partner_id UUID      NOT NULL,
  rating     FLOAT4    NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE product_types
(
  product_type_id UUID        NOT NULL,
  type_name       VARCHAR(64) NOT NULL,
  PRIMARY KEY (product_type_id)
);

CREATE TABLE products
(
  product_id        UUID           NOT NULL,
  product_type_id   UUID           NOT NULL,
  article           VARCHAR(16)    NOT NULL,
  name              VARCHAR(256)   NOT NULL,
  description       TEXT          ,
  image_url         VARCHAR(512)  ,
  width             FLOAT4        ,
  length            FLOAT4        ,
  height            FLOAT4        ,
  net_weight        FLOAT4        ,
  gross_weight      FLOAT4        ,
  certificate_s3_id VARCHAR(32)    NOT NULL,
  standard_number   VARCHAR(32)    NOT NULL,
  cost_price        DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (product_id)
);

CREATE TABLE products_manufacturing
(
  product_id         UUID           NOT NULL,
  time               INTERVAL       NOT NULL,
  cost               DECIMAL(10, 2) NOT NULL,
  workshop_num       INT4          ,
  employees_involved INT4          
);

CREATE TABLE products_materials
(
  product_id  UUID NOT NULL,
  material_id UUID NOT NULL,
  count       INT4 NOT NULL
);

CREATE TABLE supplier_types
(
  supplier_type_id UUID        NOT NULL,
  type_name        VARCHAR(32) NOT NULL,
  PRIMARY KEY (supplier_type_id)
);

CREATE TABLE suppliers
(
  supplier_id      UUID        NOT NULL,
  supplier_type_id UUID        NOT NULL,
  name             VARCHAR(32) NOT NULL,
  inn              CHAR(12)    NOT NULL,
  PRIMARY KEY (supplier_id)
);

CREATE TABLE supply_history
(
  supplier_id UUID      NOT NULL,
  material_id UUID      NOT NULL,
  count       INT4      NOT NULL,
  created_at  TIMESTAMP NOT NULL
);

CREATE TABLE units
(
  unit_id      UUID        NOT NULL,
  abbreviation VARCHAR(4)  NOT NULL,
  full_name    VARCHAR(16) NOT NULL,
  PRIMARY KEY (unit_id)
);

ALTER TABLE partner_sales_locations
  ADD CONSTRAINT FK_partners_TO_partner_sales_locations
    FOREIGN KEY (partner_id)
    REFERENCES partners (partner_id);

ALTER TABLE partner_sales_history
  ADD CONSTRAINT FK_partners_TO_partner_sales_history
    FOREIGN KEY (partner_id)
    REFERENCES partners (partner_id);

ALTER TABLE partner_sales_history
  ADD CONSTRAINT FK_products_TO_partner_sales_history
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE orders
  ADD CONSTRAINT FK_partners_TO_orders
    FOREIGN KEY (partner_id)
    REFERENCES partners (partner_id);

ALTER TABLE order_details
  ADD CONSTRAINT FK_orders_TO_order_details
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id);

ALTER TABLE order_details
  ADD CONSTRAINT FK_products_TO_order_details
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE employees_movement
  ADD CONSTRAINT FK_employees_TO_employees_movement
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);

ALTER TABLE partners
  ADD CONSTRAINT FK_bosses_TO_partners
    FOREIGN KEY (boss_id)
    REFERENCES bosses (boss_id);

ALTER TABLE partners_products_price_history
  ADD CONSTRAINT FK_partners_TO_partners_products_price_history
    FOREIGN KEY (partner_id)
    REFERENCES partners (partner_id);

ALTER TABLE partners_products_price_history
  ADD CONSTRAINT FK_products_TO_partners_products_price_history
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE products_manufacturing
  ADD CONSTRAINT FK_products_TO_products_manufacturing
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE supply_history
  ADD CONSTRAINT FK_suppliers_TO_supply_history
    FOREIGN KEY (supplier_id)
    REFERENCES suppliers (supplier_id);

ALTER TABLE supply_history
  ADD CONSTRAINT FK_materials_TO_supply_history
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE materials_receipts
  ADD CONSTRAINT FK_materials_TO_materials_receipts
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE materials_writeoff
  ADD CONSTRAINT FK_materials_TO_materials_writeoff
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE materials_writeoff
  ADD CONSTRAINT FK_products_TO_materials_writeoff
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE materials_reservations
  ADD CONSTRAINT FK_materials_TO_materials_reservations
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE materials_reservations
  ADD CONSTRAINT FK_products_TO_materials_reservations
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE material_releases
  ADD CONSTRAINT FK_materials_TO_material_releases
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE material_releases
  ADD CONSTRAINT FK_products_TO_material_releases
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE products_materials
  ADD CONSTRAINT FK_products_TO_products_materials
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

ALTER TABLE products_materials
  ADD CONSTRAINT FK_materials_TO_products_materials
    FOREIGN KEY (material_id)
    REFERENCES materials (material_id);

ALTER TABLE partners_rating
  ADD CONSTRAINT FK_partners_TO_partners_rating
    FOREIGN KEY (partner_id)
    REFERENCES partners (partner_id);

ALTER TABLE employees_passport
  ADD CONSTRAINT FK_employees_TO_employees_passport
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);

ALTER TABLE partners
  ADD CONSTRAINT FK_partner_types_TO_partners
    FOREIGN KEY (partner_type_id)
    REFERENCES partner_types (partner_type_id);

ALTER TABLE products
  ADD CONSTRAINT FK_product_types_TO_products
    FOREIGN KEY (product_type_id)
    REFERENCES product_types (product_type_id);

ALTER TABLE materials
  ADD CONSTRAINT FK_material_types_TO_materials
    FOREIGN KEY (material_type_id)
    REFERENCES material_types (material_type_id);

ALTER TABLE materials
  ADD CONSTRAINT FK_units_TO_materials
    FOREIGN KEY (unit_id)
    REFERENCES units (unit_id);

ALTER TABLE suppliers
  ADD CONSTRAINT FK_supplier_types_TO_suppliers
    FOREIGN KEY (supplier_type_id)
    REFERENCES supplier_types (supplier_type_id);

ALTER TABLE orders
  ADD CONSTRAINT FK_order_statuses_TO_orders
    FOREIGN KEY (order_status_id)
    REFERENCES order_statuses (order_status_id);

ALTER TABLE employees
  ADD CONSTRAINT FK_family_statuses_TO_employees
    FOREIGN KEY (family_status_id)
    REFERENCES family_statuses (family_status_id);

ALTER TABLE employees
  ADD CONSTRAINT FK_health_statuses_TO_employees
    FOREIGN KEY (health_status_id)
    REFERENCES health_statuses (health_status_id);

ALTER TABLE managers
  ADD CONSTRAINT FK_manager_positions_TO_managers
    FOREIGN KEY (manager_position_id)
    REFERENCES manager_positions (manager_position_id);