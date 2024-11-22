class Reservation < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_people, presence: true
  validate :date_before_start
  validate :date_before_end

  def save_reservation(reservation_params)
    self.start_date = reservation_params[:start_date]
    self.end_date = reservation_params[:end_date]
    self.total_people = reservation_params[:total_people]
    self.total_day = reservation_params[:total_day]
    self.total_amount = reservation_params[:total_amount]
    self.user_id = reservation_params[:user_id]
    self.product_id = reservation_params[:product_id]
    save
  end

  def sum_of_days
    (end_date.to_date - start_date.to_date).to_i if start_date.present? && end_date.present?
  end

  def sum_of_amount
    (product.amount * total_people * sum_of_days).to_i if start_date.present? && end_date.present?
  end

  def date_before_start
    return if start_date.blank?
    errors.add(:start_date, "開始日は今日以降のものを選択してください") if start_date < Date.today
  end

  def date_before_end
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "終了日は開始日以降のものを選択してください") if end_date < start_date
  end
end
