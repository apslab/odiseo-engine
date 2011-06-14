# == Schema Information
# Schema version: 20110601133856
#
# Table name: exercises
#
#  id            :integer         not null, primary key
#  started_on    :date
#  finished_on   :date
#  uneven        :boolean         default(FALSE)
#  close         :boolean         default(FALSE)
#  company_id    :integer
#  entries_count :integer         default(0)
#  description   :string(255)
#
# Indexes
#
#  index_exercises_on_company_id_and_started_on_and_finished_on  (company_id,started_on,finished_on) UNIQUE
#  index_exercises_on_company_id_and_close                       (company_id,close)
#  index_exercises_on_close                                      (close)
#  index_exercises_on_company_id                                 (company_id)
#

class Exercise < ActiveRecord::Base
  belongs_to :company, :counter_cache => true
  has_many :accounts
  has_many :entries, :dependent => :destroy

  before_destroy :any_entries?

  validates_uniqueness_of :started_on, :scope => [:company_id]
  validates_uniqueness_of :finished_on, :scope => [:company_id]
  validates_presence_of :started_on, :finished_on, :description, :company_id
  validates_associated :company

  validates_with Apslabs::Validators::Exercise, :started_on => :started_on, :finished_on => :finished_on, :uneven => :uneven
  validates_with Apslabs::Validators::StartBeforeOf, :field_name => :started_on, :before_of => :finished_on

  default_scope order('started_on DESC')
  scope :opened, where(:close => false)
  scope :closed, where(:close => true)

  def self.setup
    new do |e|
      e.started_on = Date.today
      e.finished_on = e.started_on + 1.year - 1.day
    end
  end

  def period
    [started_on,finished_on]
  end

  def label
    period.map{|e|e.to_s(:default)}.join('...') + ' ' + description.to_s
  end

  def short_label
    period.map(&:to_s).join('..')
  end

  def open?
    !close?
  end

  def any_entries?
    raise Apslabs::Exceptions::IsOpen if open?
    raise Apslabs::Exceptions::HasEntries if entries.any?
  end

end
