require 'csv'
require 'require_all'
require_rel '../../test/test_helper.rb'
require_rel '../../lib/application.rb'

class HandlerTest < Minitest::Test
  def setup
    @hash = {}
    @hash[:items] = [{:id => "First item", :title => "На гигапиксельную панораму попали сотни людей и Путин", :link=>"https://lenta.ru/news/2018/08/15/mashuk/", :description=>{:"#cdata-section"=>"Ресурс Gigarama опубликовал гигапиксельную панораму с образовательного форума «Машук» в Пятигорске. На нем запечатлены сотни участников мероприятия и президент России Владимир Путин, приехавший на форум 15 августа. Gigarama ранее публиковала панорамы «Бессмертного полка» и форума в Сочи."}, :category=>"Россия"},
                     {:id => "Second item", :title => "На гигапиксельную панораму попали сотни людей и Путин", :link=>"https://lenta.ru/news/2018/08/15/mashuk/", :description=>{:"#cdata-section"=>"Ресурс Gigarama опубликовал гигапиксельную панораму с образовательного форума «Машук» в Пятигорске. На нем запечатлены сотни участников мероприятия и президент России Владимир Путин, приехавший на форум 15 августа. Gigarama ранее публиковала панорамы «Бессмертного полка» и форума в Сочи."}, :category=>"Россия"},
                     {:id => "Last item", :title=>"Девушкам разрешили сделать бюстгальтер верхней одеждой", :link=>"https://lenta.ru/news/2018/08/15/sheer/", :description=>{:"#cdata-section"=>"Модные эксперты объяснили девушкам, как носить бюстгальтер в качестве верхней одежды. В первую очередь стоит сделать выбор в пользу балета — кружевного топа, который закрывает не только грудь, но и верхнюю часть живота. Сверху на него порекомендовали надеть куртку нараспашку."}, :category=>"Ценности"}]
  end

  def test_revert_handler
    handler = RevertHandler.new

    before = @hash

    processed_data = handler.handle(@hash[:items])

    puts 'after'

    puts @hash[:items]
    puts processed_data

    assert @hash[:items][0][:id] == processed_data[-1][:id]
  end
end
