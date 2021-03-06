class Player < ActiveRecord::Base
  
  has_many  :gameplays
  has_many  :matches, :through => :gameplays do
    def where_turn_of(player)
      self.select{ |m| m.active? && (m.side_to_move(:count) == m.side_of(player)) }
    end
  end

  validates_length_of :name, :maximum => 20
  validates_uniqueness_of :name


  has_one    :user, :foreign_key => :playing_as
  # --OR--
  has_one    :fbuser, :foreign_key => :playing_as

  def email; user.email; end

  def opponent_in( match = @match ) 
    return match.black if match.white == self 
    return match.white if match.black == self 
    nil
  end

end
