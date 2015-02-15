$ ->
  $('#jstree_categories').jstree({
    'core' : {
      'check_callback' : true,
      'data' : {
        'url' : (node) ->
          return 'categories.json' # GET /categoris.json を実行する
      }
    },
    "plugins" : [ "dnd" ]
  })


  # カテゴリを移動させたときに呼ばれるイベント
  $('#jstree_categories').on "move_node.jstree", (e, node) ->
    id            = node.node.id
    parent_id     = node.parent
    new_position  = node.position

    # PATCH /categories/id.json
    $.ajax({
      'type'    : 'PATCH',
      'data'    : { 'category' : { 'parent_id' : parent_id, 'new_position' : new_position } },
      'url'     : "/categories/#{id}.json"
    })


  # 選択されているノードの子として新しいノードを作成する
  $('#create_category').on 'click', ->
    jstree = $('#jstree_categories').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)
    selected = selected[0]

    # POST /categories.json
    $.ajax({
      'type'    : 'POST',
      'data'    : { 'category' : { 'name' : 'New node', 'parent_id' : selected } },
      'url'     : '/categories.json',
      'success' : (res) ->
        selected = jstree.create_node(selected, res)
        jstree.edit(selected) if (selected)
    })


  # 選択されているノードの名前を変更する
  $('#rename_category').on 'click', ->
    jstree = $('#jstree_categories').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)

    selected = selected[0]
    jstree.edit(selected);


  # ノードの名前の変更が確定されたときに呼ばれるイベント
  $('#jstree_categories').on 'rename_node.jstree', (e, obj) ->
    id           = obj.node.id
    renamed_name = obj.text

    # PATCH /categories/id.json
    $.ajax({
      'type'    : 'PATCH',
      'data'    : { 'category' : { 'name' : renamed_name } },
      'url'     : "/categories/#{id}.json"
    })


  # 選択されているノードを削除する
  $('#delete_category').on 'click', ->
    jstree = $('#jstree_categories').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)

    selected = selected[0]
    id = selected

    # DELETE /categories/id.json
    $.ajax({
      'type'    : 'DELETE',
      'url'     : "/categories/#{id}.json",
      'success' : ->
        jstree.delete_node(selected)
    })
