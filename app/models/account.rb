# == Schema Information
# Schema version: 20110601133856
#
# Table name: accounts
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  code          :string(255)
#  archive       :boolean
#  company_id    :integer
#  parent_id     :integer
#  lft           :integer
#  rgt           :integer
#  depth         :integer
#  details_count :integer         default(0)
#
# Indexes
#
#  index_accounts_on_company_id_and_parent_id  (company_id,parent_id)
#  index_accounts_on_lft_and_rgt               (lft,rgt)
#  index_accounts_on_company_id                (company_id)
#

class Account < ActiveRecord::Base
  acts_as_nested_set :scope => :exercise

  belongs_to :exercise
  has_one :company, :through => :exercise

  has_many :details do
    def credit
      sum(:credit)
    end

    def debit
      sum(:debit)
    end

    def balance
      sum('credit - debit').to_f
    end
  end

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:exercise_id, :parent_id], :on => :update
  validates_uniqueness_of :code, :scope => [:exercise_id, :parent_id], :on => :update

  before_destroy :account_in_use? && :account_isnt_leaf?

=begin
  def self.from(user)
    where(:company_id => (user.try(:companies)||[]).map(&:id))
  end
=end

  def label_html
    @label ||= [name.capitalize, code_html].compact.join(' ')
  end

  def code_html
    "<sup>#{code.upcase}</sup>" unless code.blank?
  end

  def account_in_use?
    raise Apslabs::Exceptions::HasDetails if details.any?
  end

  def account_isnt_leaf?
    raise unless self.leaf?
  end

end

