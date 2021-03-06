class Api::V1::Versions::DownloadsController < Api::BaseController
  def index
    if version
      render :json => Download.counts_by_day_for_version(version)
    else
      render :text => "This rubygem could not be found.", :status => :not_found
    end
  end

  def search
    start, stop = [params[:from], params[:to]].map do |d|
      Date.parse(d)
    end

    if version
      render :json => Download.counts_by_day_for_version_in_date_range(version, start, stop)
    else
      render :text => "This rubygem could not be found.", :status => :not_found
    end
  end

  private

  def version
    full_name = params[:version_id].chomp(".json")
    Version.find_by_full_name_and_indexed(full_name, true)
  end
end
