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

    initialize: function(options) {
      this.$rootEl = options.$rootEl;
      this.collection = new Lists();
      this.collection.fetch();

      this.listenTo(this.collection, 'sync', this.render);
    },
    render: function() {
      this.$el.html(this.template({
        lists: this.collection
      }));
      this.$rootEl.html(this.$el);
      return this;
    }
  });

  var TodoIndex = Backbone.View.extend({
    template: _.template($('#todo-index-tpl').html()),

    initialize: function(options) {
      this.$rootEl = options.$rootEl;
      this.listId = options.listId;
      this.collection = new Todos();
      this.collection.fetch({
        data: { list_id: this.listId }
      });

      this.listenTo(this.collection, 'sync', this.render);
    },

    render: function() {
      this.$el.html(this.template({
        todos: this.collection
      }));
      this.$rootEl.html(this.$el);
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
      new ListIndex({
        $rootEl: this.$rootEl
      });
    },

    show: function(id) {
      console.log('show');
      new TodoIndex({
        $rootEl: this.$rootEl,
        listId: id
      });
    }
  });


  // Start
  new Router({
    $rootEl: $('#content')
  });
  Backbone.history.start();
});
