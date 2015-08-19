module KcCourses
  class ChaptersController < KcCourses::ApplicationController
    before_action :set_course

    #def index
      #@chapters = KcCourses::Chapter.all
    #end
    
    def show
      @chapter = @course.chapters.find params[:id]
      #authorize! :manage, @chapter
      #@course = @chapter.course
      #@course_wares = @chapter.course_wares
    end

    def new
      @chapter = @course.chapters.new

      #authorize! :manage, Chapter
      #@course = Course.find(params[:course_id])
      #@chapter = @course.chapters.new

      #if request.xhr?
        #return render :json => {
          #:html => (
            #render_cell :course, :chapter_table_ajax_form, :chapter => @chapter
          #)
        #}
      #end
    end

    def create
      @chapter = @course.chapters.new chapter_params
      #authorize! :manage, Chapter
      #@course = Course.find(params[:course_id])
      #@chapter = @course.chapters.build(params[:chapter])
      #@chapter.creator = current_user
      #if @chapter.save
        #if request.xhr?
          #return render :json => {
            #:count => @course.chapters.count,
            #:html => (
              #render_cell :course_ware, :manage_chapter_table, :chapters => [@chapter]
            #)
          #}
        #end

        #return redirect_to "/manage/courses/#{@course.id}"
      #end
      return redirect_to [@course, @chapter] if @chapter.save
      render :action => :new
    end

    def edit
      @chapter = @course.chapters.find(params[:id])
      #authorize! :manage, @chapter
      #@course = @chapter.course

      #if request.xhr?
        #return render :json => {
          #:html => (
            #render_cell :admin, :chapter_ajax_edit_form, :chapter => @chapter, :user => current_user
          #)
        #}
      #end
    end


    def update
      @chapter = @course.chapters.find(params[:id])
      return redirect_to [@course, @chapter] if @chapter.update_attributes chapter_params
      render :action => :new
      #authorize! :manage, @chapter
      #@course = @chapter.course
      #if @chapter.update_attributes params[:chapter]
        
        #if request.xhr?
          #return render :json => {
            #:html => (
              #render_cell :course, :chapter_baseinfo, :chapter => @chapter
            #)
          #}
        #end

        #return redirect_to "/manage/chapters/#{@chapter.id}"
      #end
      #render :action => :edit, :id => @chapter.id
    end

    def destroy
      @chapter = KcCourses::Chapter.find(params[:id])
      @chapter.destroy
      redirect_to @course
      #authorize! :manage, @chapter
      #@course = @chapter.course
      #@chapter.destroy

      #if request.xhr?
        #return render :json => {
          #:status => 'ok',
          #:count => @course.chapters.count
        #}
      #end

      #redirect_to "/manage/courses/#{@course.id}"
    end

    def move_up
      @chapter = @course.chapters.find(params[:id])
      @chapter.move_up
      redirect_to @course
      #@chapter = KcCourses::Chapter.find(params[:id])
      #authorize! :manage, @chapter
      #@course = @chapter.course
      #@chapter.move_up

      #if request.xhr?
        #return render :json => {
          #:status => 'ok',
          #:html => (render_cell :course_ware, :manage_chapter_table, :chapters => [@chapter])
        #}
      #end

      #return redirect_to "/manage/courses/#{@course.id}"
    end

    def move_down
      @chapter = @course.chapters.find(params[:id])
      @chapter.move_down
      redirect_to @course
      #@chapter = KcCourses::Chapter.find(params[:id])
      #authorize! :manage, @chapter
      #@course = @chapter.course
      #@chapter.move_down

      #if request.xhr?
        #return render :json => {
          #:status => 'ok',
          #:html => (render_cell :course_ware, :manage_chapter_table, :chapters => [@chapter])
        #}
      #end

      #return redirect_to "/manage/courses/#{@course.id}"
    end

    private
    def set_course
      @course = Course.find params[:course_id]
    end

    def chapter_params
      params.require(:chapter).permit(:title, :desc)
    end

  end
end

