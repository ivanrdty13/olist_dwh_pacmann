# Olist Data Warehouse (Pacmann)

This project is a Data Warehouse (DWH) implementation for the Olist e-commerce dataset, built with PostgreSQL and Docker. It was developed as part of a learning module at Pacmann Academy.

---

## 🧱 Project Overview

The project includes:

- A **source PostgreSQL database** simulating raw transactional data.
- A **DWH PostgreSQL database** with a dimensional model (star schema).
- Initialization SQL scripts for both environments.
- Docker containers for easy local deployment.

**Clone the repository**


`git clone https://github.com/ivanrdty13/olist_dwh_pacmann.git`
`cd olist_dwh_pacmann`

**Start The Docker**

`docker-compose up -build`

**Database Connection**

You can see the `.yml`

## 📚 References

- [Olist Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Docker Docs](https://docs.docker.com/)
