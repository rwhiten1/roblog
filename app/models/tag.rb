class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles #, :after_add => :increment_article_count, :after_remove => :decrement_article_count
  @@average_tag_usage = nil
  @@tag_usage_standard_dev = nil

  def increment_article_count
    Tag.increment_counter(:articles_count,self.id)
  end

  def decrement_article_count
    Tag.decrement_counter(:articles_count, self.id)
  end

  def self.average_usage
    if @@average_tag_usage == nil
      tag_counts = Tag.find_by_sql("SELECT articles_count FROM tags")
      sum = 0
      tag_counts.each do |c|
        sum += c.articles_count
      end
      @@average_tag_usage = sum/tag_counts.length
    else
      @@average_tag_usage
    end

  end

  def self.tag_usage_stddev
    if @@average_tag_usage == nil
        average_usage
    end

    if @@tag_usage_standard_dev == nil
       tag_count = Tag.find_by_sql("SELECT articles_count FROM tags")
       sum = 0
      tag_count.each do |count|
        sum += (count.articles_count - @@average_tag_usage)**2
      end
      @@tag_usage_standard_dev = Math.sqrt(sum)
      @@tag_usage_standard_dev.round(2)
    else
      @@tag_usage_standard_dev.round(2)
    end
  end

  def deviations
    cnt = Tag.find_by_sql ["SELECT articles_count FROM tags WHERE id=?",self.id]
    t = cnt[0].articles_count - @@average_tag_usage #figure out the distance from the mean
    puts "DISTANCE: #{t}"
    (t/@@tag_usage_standard_dev).round(0)
  end


end
