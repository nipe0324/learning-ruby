class Post extends React.Component {

  render() {
    return (
      <li>
        <h3>{this.props.post.category.name}</h3>
        <h4>{this.props.post.title}</h4>
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
