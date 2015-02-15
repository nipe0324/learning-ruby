class Category < ActiveRecord::Base
  acts_as_nested_set

  # ルートノードに移動させた場合は、parent_id は "#"になるので、
  # ルートに移動させる move_to_root メソッドを呼ぶ
  # 親ノードがある場合は、parent_id を 更新する
  def parent_id=(parent_id)
    if parent_id == '#'
      move_to_root
    else
      super(parent_id)
    end
  end

  # ルートノードに移動させた場合は、親ノード(parent)がnilのため、ルートの兄弟配列から移動先を特定する
  # 親ノードがある場合は、move_to_child_with_indexメソッドで移動する
  def new_position=(new_position)
    if parent.blank?
      prev_node = root.siblings[new_position.to_i - 1]
      move_to_right_of prev_node
    else
      move_to_child_with_index(parent, new_position.to_i)
    end
  end
end
