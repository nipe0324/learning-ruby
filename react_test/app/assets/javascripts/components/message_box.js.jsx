var MessageBox = React.createClass({
  getInitialState: function() {
    return {　messages:  [],　isLoading: true　};
  },

  componentDidMount: function() {
    $.ajax({
      url:      this.props.url,
      dataType: 'json',
      cache:    false,
      success: function(messages) {
        this.setState({ messages: messages, isLoading: false });
      }.bind(this),
      eror: function(_xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  handleMessageSubmit: function(message) {
    $.ajax({
      url:      this.props.url,
      dataType: 'json',
      type:     'POST',
      data:     message,
      success: function(message) {
        var newMessages = this.state.messages.concat(message);
        this.setState({ messages: newMessages });
      }.bind(this),
      error: function(_xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    var messageItems = this.state.messages.map(function(message) {
      return (
        <MessageItem key={message.id} message={message}/>
      );
    });

    if (this.state.isLoading) {
      return (
        <div>ロード中</div>
      );
    } else {
      return (
        <div className="messageBox">
          {messageItems}
          <MessageForm onMessageSubmit={this.handleMessageSubmit}/>
        </div>
      );
    }
  }
});
