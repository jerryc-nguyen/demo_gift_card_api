module PaginationParams
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10
  MAX_PER_PAGE = 100

  private

  def page
    value = params[:page]&.to_i
    value&.positive? ? value : DEFAULT_PAGE
  end

  def per_page
    value = params[:per_page]&.to_i
    value = DEFAULT_PER_PAGE unless value&.positive?

    [value, MAX_PER_PAGE].min
  end
end
