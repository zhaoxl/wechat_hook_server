module ApplicationHelper
  def chaos_paginate model
    total_results_count = model.respond_to?(:total_entries) ? model.total_entries : model.count
    row = %Q{
      <div class="row">
        <div class="col-sm-5">
          <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">#{model.per_page}条/页&nbsp;&nbsp;共#{model.total_pages}页&nbsp;&nbsp;共#{total_results_count}条</div>
        </div>
        <div class="col-sm-7">
          <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
            #{will_paginate model, renderer: BootstrapPagination::BootstrapNew}
          </div>
        </div>
      </div>
    }
    raw row
  end
  
  #字符串截取（一个英文字母算0.5）
  def truncate_u(text, length = 30, truncate_string = "...")
    return "" unless text
    return text if text.length < length
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end
  
  
end
