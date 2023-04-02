require_relative './posts'

class PostsRepository
  def all
    sql = 'SELECT * FROM posts;'
    results = DatabaseConnection.exec_params(sql, [])
    posts = []
    results.each do |record|
      post = Post.new
      post.id = record['id'].to_i
      post.title = record['title']
      post.content = record['content']
      post.views = record['views'].to_i
      post.user_id = record['user_id'].to_i
      posts << post
    end
    return posts
  end
end