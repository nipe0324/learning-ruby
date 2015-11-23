var MessageItem = React.createClass({
  render: function() {
    return (
      <div className="message">
        <h2 className="messageUser">{this.props.message.user}</h2>
        <span>{this.props.message.text}</span>
      </div>
    );
  }
});
