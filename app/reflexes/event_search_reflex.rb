class EventSearchReflex < ApplicationReflex
  def search
    # Assuming you get search parameters from element's dataset or parameters
    service = EventSearchService.new(
      element.dataset[:city],
      element.dataset[:state],
      element.dataset[:distance],
      element.dataset[:genre_id]
    )

    @events = service.search
  end
end
