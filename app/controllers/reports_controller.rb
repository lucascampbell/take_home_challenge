class ReportsController < ApplicationController
  layout  'pdf', only: [:export_pdf]

  def index
    @reports = Report.order("created_at DESC")
  end

  def show
    ids          = Item.select('id').where("report_id = ?",params[:id])
    @style_items = Style.includes(:items).joins(:items).where("items.id in (?)",ids).order(:type)
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy if report
    flash[:notice] = "Deleted report successfully."
    redirect_to action: :index
  end

  def export_pdf
    report       = Report.find(params[:id])
    ids          = Item.select('id').where("report_id = ?",params[:id])
    @style_items = Style.includes(:items).joins(:items).where("items.id in (?)",ids).order(:type)

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('show.html.erb', :layout => 'pdf.html.erb')
    )
    save_path = Rails.root.join('tmp', "#{report.name}.pdf")

    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    send_file save_path, :type => 'application/pdf', :disposition => 'attachment' 
  end

   def upload
    begin
      Report.consume_csv(params[:file])
    rescue Exception => e 
      puts "Exception: #{e.message}"
    end
    render :json => {text:'success'}
  end
end
