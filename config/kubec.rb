# Rails
deployment :web do
  label :app, :web

  template do
    label :app, :web

    container :web do
      image fetch(:image)
      port 3000

      env 'DATABASE_URL', fetch(:database_url)
      env 'SECRET_KEY_BASE', fetch(:secret)
    end
  end
end

service :web do
  select :app, :web
  # Use `load_balancer ip: 'x.x.x.x'` if you are using AWS or GCP
  node_port
  port 80, 3000
end

deployment :db do
  label :app, :db

  template do
    label :app, :db

    container :db do
      image 'postgres:10'
      port 5432

      env 'POSTGRES_DB', 'example'
    end
  end
end

service :db do
  select :app, :db
  port 5432, 5432
end
