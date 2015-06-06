$(document).ready(function() {

  _.templateSettings = {
      interpolate: /\{\{\=(.+?)\}\}/g,
      evaluate: /\{\{(.+?)\}\}/g
  };

  var Todo = Backbone.Model.extend({});
  var Todos = Backbone.Collection.extend({
    model: Todo,
    url: '/api/todos',
  });
  var List = Backbone.Model.extend({
  });
  var Lists = Backbone.Collection.extend({
    model: List,
    url: '/api/lists',
  });

  var ListIndex = Backbone.View.extend({
    template: _.template($('#list-index-tpl').html()),

    render: function() {
      this.$el.html(this.template({
        lists: this.collection
      }));
      return this;
    }
  });

  var TodoIndex = Backbone.View.extend({
    template: _.template($('#todo-index-tpl').html()),

    render: function() {
      this.$el.html(this.template({
        todos: this.collection
      }));
      return this;
    }
  })

  var Router = Backbone.Router.extend({
    initialize: function(options) {
      this.$rootEl = options.$rootEl;
    },

    routes: {
      '': 'index',
      'lists/:id': 'show',
    },

    index: function() {
      console.log('index');
      var self = this;
      var lists = new Lists();
      lists.fetch({
        success: function(model, res) {
          var listIndex = new ListIndex({
            collection: lists
          });
          self.$rootEl.html(listIndex.render().$el);
        }
      });
    },

    show: function(id) {
      console.log('show');
      var self = this;
      var todos = new Todos();

      todos.fetch({
        data: { list_id: id },
        success: function(model, res) {
          var todoIndex = new TodoIndex({
            collection: todos
          });
          self.$rootEl.html(todoIndex.render().$el);
        }
      });
    }
  });


  // Start
  new Router({
    $rootEl: $('#content')
  });
  Backbone.history.start();
});
