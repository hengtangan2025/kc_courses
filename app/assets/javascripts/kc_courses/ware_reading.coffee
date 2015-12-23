class @CustomReadingProgress
  before_load: ($el)->
    console.log 'before_load'
    console.log $el
  loaded: ($el, data) ->
    console.log 'loaded'
    console.log data.chapters
    $.each data.chapters, (index) ->
      console.log this
  error: ($el, data) ->
    console.log 'error'
    console.log $el
    console.log data
  finally: ($el)->
    console.log 'finally'
    console.log $el

class @WareReading
  constructor: (@configs)->
    @$el = jQuery(@configs["selector"])
    @progress = new @configs["progress_class"]()
  
  load: ()->
    if @$el.length > 0
      @progress.before_load(@$el)
      course_id = @$el.data("course-id")
      if !course_id
        @progress.error(@$el, {result: "不能读取course_id"})
        @progress.finally(@$el)
        return 
      @progress.before_load(@$el)
      jQuery.ajax
        url: "/api/courses/#{course_id}/progress"
        method: "GET"
        type: "json"
        success: (data) =>
          @progress.loaded(@$el,data)
          @progress.finally(@$el)
        error: (data) =>
          @progress.error(@$el,data)
          @progress.finally(@$el)
    else
      @progress.error(@$el, {result: "#{@configs['selector']} 未选中任何DOM"})
      @progress.finally(@$el)

jQuery(document).on 'ready page:load', ->
  configs = 
    progress_class: CustomReadingProgress
    selector: '.panel-wares'

  window.ware_reading = new WareReading(configs)
  window.ware_reading.load()
