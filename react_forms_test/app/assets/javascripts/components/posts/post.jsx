class Post extends React.Component {

  render() {
    return (
      <li>
        <h4>{this.props.post.title}</h4>
        <div><b>Category:</b> {this.props.post.category.name}</div>
        <div><b>Tags:</b> {this.props.post.tags.map((tag) => tag.name).join(', ')}</div>
        <p>
          {this.props.post.body}
        </p>
        <Link to='editPost' params={{postId: this.props.post.id}} className="btn btn-xs btn-default">Edit</Link>
      </li>
    )
  }

}

Post.propTypes = {
  post: React.PropTypes.object.isRequired
}
