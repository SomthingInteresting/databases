require_relative './users'

class UsersRepository
  def all
    sql = 'SELECT id, name, email FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id'].to_i
      user.name = record['name']
      user.email = record['email']

      users << user
    end

    return users
  end

  def find(id)
    sql = 'SELECT id, name, email FROM users WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    user = User.new
    user.id = record['id'].to_i
    user.name = record['name']
    user.email = record['email']

    return user
  end

  def create(user)
    sql = 'INSERT INTO users (name, email) VALUES ($1, $2);'
    sql_params = [user.name, user.email]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(user)
    sql = 'DELETE FROM users WHERE id = $1'
    sql_params = [user]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end