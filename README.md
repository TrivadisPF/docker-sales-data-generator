# docker-sales-data-generator

Sales Data Generator Docker Image for <https://github.com/garystafford/streaming-sales-generator>.

## Running the simulator with default configuration settings

By default the simulator is configured to connect to a Kafka cluster in the same docker 
network named `kafka-1` on port `190902`. Therefore when running the container, specify the name of the network with the `--network` parameter.

```bash
docker run -ti --network <docker-network> trivadis/sales-data-generator:latest
```

## Running the simulator with custom configuration settings

if you want to change the configuration, create a `configuration.ini` file with the following configuration

```bash
[KAFKA]
# use kafka:29092 if running in a within docker container
bootstrap_servers = localhost:9092

# kafka authentication method: plaintext or sasl_scram
auth_method = plaintext

# optional: sasl_scram authentication only
sasl_username = foo
sasl_password = bar

# topic names
topic_products = demo.products
topic_purchases = demo.purchases
topic_inventories = demo.inventories

[SALES]
# minimum sales frequency in seconds (debug with 1, typical min. 120)
min_sale_freq = 2

# maximum sales frequency in seconds (debug with 3, typical max. 300)
max_sale_freq = 5

# number of transactions to generate
number_of_sales = 1000

# chance of items purchased in a single transaction being 1 vs. 2 or 3 on scale of 1 to 20?
transaction_quantity_one_item_freq = 13

# chance of product quantity being 1 vs. 2 or 3 on scale of 1 to 30?
item_quantity_one_freq = 24

# chance of being member on scale of 1 to 10?
member_freq = 3

# percentage discount for smoothie club members as decimal
club_member_discount = .10

# chance of adding a supplement to group 1 smoothies on scale of 1 to 10?
add_supp_freq_group1 = 5

# chance of adding a supplement to group 2 smoothies on scale of 1 to 10?
add_supp_freq_group2 = 2

# cost of adding supplements to smoothie
supplements_cost = 1.99

[INVENTORY]
# minimum inventory level (higher min. == more restocking events)
min_inventory = 10

# restocking amount (lower amount == more restocking events)
restock_amount = 15
```

and map the `configuration.ini` file into the container when starting it

```bash
docker run -ti  -v configuration.ini:/sales_generator/configuration trivadis/sales-data-generator:latest
```