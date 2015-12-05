class TagsInput extends BaseInput {

  constructor(props) {
    super(props);
    this.handleKeyDown = this.handleKeyDown.bind(this);
    this.handleChange  = this.handleChange.bind(this);

    this.state = {
      tags:   this.props.value,
      newTag: ''
    }

    this.counter = 0;
  }

  // onKeyDown event is triggered before onChange event
  handleKeyDown(e) {
    if (e.keyCode === ENTER_KEY) {
      e.preventDefault();
      let tag = { key: this._nextId(), name: this.state.newTag };
      if (tag.name) {
        let newTags = this.state.tags.concat([tag]);
        this.setState({
          tags: newTags,
          newTag: ''
        });
        // update resouce's tags data
        this.props.onInputChange(this.props.name, newTags);
      }
    }
  }

  // overide BaseInput#handleChange
  handleChange(e) {
    this.setState({ newTag: e.target.value });
  }

  // Set `_destroy: true` to delete object for `accepts_nested_attributes_for` method if `id` exists
  // @see http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
  handleClickRemoveTag(tag, e) {
    e.preventDefault();
    let tags = this.state.tags;
    if (tag.id) {
      tag['_destroy'] = true;
      _.merge(tags, tag);
    } else {
      tags = _.without(tags, tag);
    }
    this.setState({ tags: tags });

    // update resouce's tags data
    this.props.onInputChange(this.props.name, tags);
  }

  render() {
    // console.log(this.state);
    return (
      <InputWrapper errors={this.props.errors}>
        <label>{this.props.name} <i>(Press Enter to add a tag)</i></label>
        <div>
          {this._buildTags(this.state.tags)}
        </div>
        <input type="text"
          className={this.props.className}
          name={this.props.name}
          value={this.state.newTag}
          onKeyDown={this.handleKeyDown}
          onChange={this.handleChange}/>
      </InputWrapper>
    );
  }

  _buildTags(tags) {
    let viewTags = _.reject(tags, (tag) => { return tag['_destroy'] === true; } );

    return viewTags.map(tag => {
      return (
        <span key={tag.key} className="label label-info">
          {tag.name}
          <a href="javascript:void(0)" onClick={this.handleClickRemoveTag.bind(this, tag)}>x</a>
        </span>
      );
    });
  }

  _nextId() {
    this.counter += 1;
    return this.counter;
  }
}

TagsInput.propTypes = _.merge({}, BaseInput.propTypes, {
  value:     React.PropTypes.array,
  otherTags: React.PropTypes.array
});

TagsInput.defaultProps = _.merge({}, BaseInput.defaultProps, {
  value:     [],
  otherTags: []
});
