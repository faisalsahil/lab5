desc 'Ensure that code is not running in production environment'
task :not_production do
  #raise 'do not run in production' if Rails.env.production?
end

desc 'sets up the project by running migration and populating sample data'
task setup: [:environment, :not_production, 'db:drop', 'db:create', 'db:migrate'] do
  ["setup_sample_data"].each { |cmd| system "rake #{cmd}" }
end

desc 'Deletes all records and populates sample data'
task setup_sample_data: [:environment, :not_production] do

  SampleDataService.new.process

  puts 'sample data was added successfully'
end

class SampleDataService

  def process
    delete_all_records_from_all_tables
    create_user email: 'john@example.com', role: 'super_admin'
    create_sample_data
  end

  private

  def create_user( options = {} )
    user_attributes = { email: 'john@example.com', password: 'welcome', first_name: "John",
                        last_name: "Smith", role: "super_admin" }
    attributes = user_attributes.merge options
    User.create! attributes
  end

  def delete_all_records_from_all_tables
    ActiveRecord::Base.connection.schema_cache.clear!

    Dir.glob(Rails.root + 'app/models/*.rb').each { |file| require file }

    ActiveRecord::Base.descendants.each do |klass|
      klass.reset_column_information
      klass.delete_all
    end
  end

  def create_sample_data

    ebook_category = Category.create! name: 'Ebook'

    ebook_category.products.create! name: 'How credit card processing works ebook',
                                    price: 13,
                                    description: how_credit_cards_works_content,
                                    pic_name: 'credit-card-ebook.png'

    ebook_category.products.create! name: 'How we work',
                                    price: 19,
                                    description: how_we_work_desc,
                                    pic_name: 'how-we-work.png'

    product = ebook_category.products.create! name: 'Conversation with API builders',
                                              price: 17,
                                              description: conversation_with_api_builders_desc,
                                              pic_name: 'conv-api-builders-ebook.png'

    product.reviews.create! headline: 'Good book on API strategy',
                            content: review_1,
                            user_id: User.first.id

    product.reviews.create! headline: 'Very good reference for building RESTful APIs',
                            content: review_2,
                            user_id: User.first.id

    video_category = Category.create!name: 'Video'


    video_category.products.create! name: 'Learn RubyMotion video course',
                                    price: 53,
                                    description: learn_rubymotion_content,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Rails internals',
                                    price: 33,
                                    description: rails_internals_content,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Learn jQuery',
                                    price: 29,
                                    description: learn_jquery_content,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Learn EmberJS',
                                    price: 21,
                                    description: learn_emberjs_desc,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'JavaScript debugging in webkit',
                                    price: 9,
                                    description: javascript_debugging_in_webkit_desc,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'pjax on rails',
                                    price: 9,
                                    description: pjax_on_rails_desc,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Squashing commits in Git',
                                    price: 9,
                                    description: squashing_commits_in_git,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Recording videos on mac using screenflow',
                                    price: 9,
                                    description: record_videos_using_screenflow,
                                    pic_name: 'coming-soon.jpg'

    video_category.products.create! name: 'Recording videos on mac using quicktime',
                                    price: 9,
                                    description: record_videos_using_quicktime,
                                    pic_name: 'coming-soon.jpg'

  end

  def pjax_on_rails_desc
    content = <<-END
      pjax is a jQuery plugin that uses ajax and pushState to deliver a fast browsing experience with real permalinks, page titles, and a working back button. pjax works by grabbing html from your server via ajax and replacing the content of a container on your page with the ajax'd html.

      This video shows how to make use of pjax techinque.
    END

    content
  end

  def javascript_debugging_in_webkit_desc
    content = <<-END
      These days we are writing more and more JavaScript. However we do not have too many tools to debug JavaScript application.

      Chrome developer tool is a good tool to debug JavaScript code. This video goes in depth about how to use this excellent tool.
    END

    content
  end

  def squashing_commits_in_git
    content = <<-END
      Squashing commits in git can be painful sometimes. This video will help.
    END

    content
  end

  def record_videos_using_screenflow
    content = <<-END
      Screenflow is not a free tool. However it makes editing videos simple. If quicktime is not cutting it for you and you want
      to have better control of how your videos look then screenflow is the right tool.

      This video discusses how to use screenflow.
    END

    content
  end

  def record_videos_using_quicktime
    content = <<-END
      Quicktime comes with mac and Quicktimes makes recording videos super simple.

      In this video we will see how to record and then how to export videos in different formats after recording is done.
    END

    content
  end

  def learn_jquery_content
    content = <<-END
      jQuery needs no introduction.

      This video course covers a lot of ground from basic selectors to advanced deferred concepts.
    END

    content
  end

  def learn_emberjs_desc
    content = <<-END
      EmberJS is a JavaScript framework to make rich client applications.

      In this video you will see how to get started with EmberJS.
    END

    content
  end

  def rails_internals_content
    content = <<-END
      Rails is magical. It does a lot of things under the hood. Watch these four videos to learn about how Rails does what it does so beautifully.
    END

    content
  end

    def learn_rubymotion_content
      content = <<-END
      RubyMotion is a toolchain that lets you quickly develop and test native iOS and OS X applications for iPhone, iPad and Mac, all using the Ruby.

      This video course contains 17 videos which discusses in detail how to use RubyMotion to build iPhone app using the API of the web application.
      END

      content
    end

    def review_2
      content = <<-END
      As we re-architect existing services to expose RESTful API's, we've found this book provides good reference material. Topics such as resources, representations and the challenging aspects of hypermedia are easy to find and digest. The related diagrams are very helpful for grasping details and complexities.

      The examples are too simplistic for anything beyond self-training projects (all too typical among books) Finally, we were disappointed that this book contains far too little on identity & federation topics. OAuth coverage is scant; nothing on SAML. Although other books provide good coverage of these topics, books on RESTful API's really need to treat this as one of the core topic areas.
      END

      content
    end

    def how_credit_cards_works_content
      content = <<-END
        In the credit card processing world the jargons can be overwhelming sometimes. This ebook lays out step by step what happens when you swipe your
        credit card at the starbucks.

        This ebook is available online at http://hccpw.bigbinary.com .
      END

      content
    end

    def how_we_work_desc
      desc = <<-END
      Rails is an opinionated frameworks. By using convention over configuration it removes trivial choices. However that still leaves room for handling same problem different ways.

      At BigBinary we have our own opinion over what Rails provides. For example we use MiniTest over Rspec. We prefer fixtures over factory girl. We use circleci, honeybadger and flowdock.

      As the title suggests this ebook captures how BigBinary works.
      END

     desc
    end

  def conversation_with_api_builders_desc
    desc = <<-END
    At BigBinary we have seend and worked with lots of bad APIs. APIs can be bad in many ways but one common theme among all bad APIs is that they all send special code which indicates if the request was succesfully processed or not. And that's not needed.

    This ebook outlines how to use response code built in in any http response. In this way API authors do not need to build their own response code mechanism.
    END

    desc
  end

  def review_1
    content = <<-END
    This is one of the first books on strategic part of API in software industry. APIs: A Strategy Guide is not for developers or designers but for non-technical folks of Software industry - PMs, Business Development staff, C Level Executives and anyone who is interested in Software marketing and Sales and its management.

    Book is written in very lucid manner though in initial chapters same information and facts are repeated but still overall book maintains good flow.

    Mix of Authors makes good combination. Provider of API related products and Services - Greg Brail, CTO Apigee ([...] customer - Daniel Jacobson, Director of Engineering Netflix API and Researcher, Speaker, & Entrepreneur - Dan Woods.

    Book is consisting of eleven chapters and each chapter takes a dive into API strategy and business. Neither a deep dive nor a shallow one.

    Book is certainly a good read and going to be on my book shelf for long time.
    END

    content
  end

end

