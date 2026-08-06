# Gift Card API


## 🚀 Getting Started

### Prerequisites
* **Ruby**: `3.1.0` (managed by `rbenv`, `rvm`, or `asdf`)
* **Rails**: `~> 7.1.6`
* **Database**: PostgreSQL 14+ (or run via Docker)

### Installation & Database Setup
1. **Install dependencies**:
   ```bash
   bundle install
   ```

2. **Configure environment variables**:
   Copy the example environment template and update connection strings if necessary:
   ```bash
   cp .env.example .env.development
   cp .env.example .env.test
   ```
   *Note: `.env.test`'s `DATABASE_URL` should point to a separate database (e.g., `_test`) to prevent test runs from wiping development data.*

3. **Initialize the database**:
   Create and migrate the PostgreSQL databases:
   ```bash
   bundle exec rails db:prepare
   ```

---

## 🛠 Running the Application

### Start Development Server
```bash
bin/rails server
```
The API will be available locally at `http://localhost:3000`.

---

## 🧪 Testing

The project uses **RSpec** and **FactoryBot** for automated unit and request testing.

### Run all tests
```bash
bundle exec rspec
```

---

## 🔑 Authentication Architecture

The application has two distinct user namespaces with different authentication mechanisms:

1. **Admin Endpoints (`/api/v1/admin/*`)**
   * **Mechanism**: JWT Token-based.
   * **Header**: `Authorization: Bearer <jwt_token>`
   * **Login**: Authenticate at `/api/v1/admin/auth/login` using email and password.

2. **Client Endpoints (`/api/v1/clients/*`)**
   * **Mechanism**: API Key.
   * **Header**: `X-Api-Key: <client_api_key>`
   * **Client Setup**: Admins can register clients via `/api/v1/admin/clients` which generates the API key automatically.

---

## 📦 Key Technologies Used
* **[dotenv-rails](https://github.com/bkeepers/dotenv)**: Environment variables management.
* **[rspec-rails](https://github.com/rspec/rspec-rails)**: Testing framework.
* **[factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)**: Test fixture replacement.
* **[pg](https://github.com/ged/ruby-pg)**: PostgreSQL integration.
* **[kaminari](https://github.com/kaminari/kaminari)**: API response pagination.
* **[paranoia](https://github.com/rubysherpa/paranoia)**: Soft-deletion of gift cards.
* **[audited](https://github.com/collectiveidea/audited)**: User/Client activity auditing and logging.
