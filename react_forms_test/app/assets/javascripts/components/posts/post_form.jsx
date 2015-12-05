class PostForm extends BaseForm {

  constructor(props) {
    super(props);
    this.store = PostStore;
  }

  componentDidMount() {
    $.when(
      CategoryStore.getResources(),
      TagStore.getResources()
    ).then((categories, tags) => {
      this.setState({
        loaded:     true,
        categories: categories[0].categories,
        tags:       tags[0].tags
      });
    });
  }

  render() {
    if (!this.state.loaded) { return <div>Loading...</div>; }

    let destroyButton;
    if (this.props.resource.id) {
      destroyButton = <button className="btn btn-danger pull-right" onClick={this.handleDestroy}>Destroy</button>;
    }

    console.log(this.state.resource);
    return (
      <form onSubmit={this.handleSubmit}>
        <SelectInput {...this.getInputProps('category_id')} options={this.state.categories} />
        <TagsInput {...this.getInputProps('tags')} otherTags={this.state.tags} />
        <TextInput {...this.getInputProps('title')} />
        <TextareaInput {...this.getInputProps('body')} />
        <Link to="posts" className="btn btn-default">Cancel</Link>
        <button type="submit" className="btn btn-primary pull-right">Save</button>
        {destroyButton}
      </form>
    )
  }

}
