module RakeHelper
  def parse_times(benchmark)
    bm_string = benchmark.to_s
    bm_hash = {}
    ['loops', 'joins', 'includes'].each do |qry| 
      start = bm_string.index('(') + 1
      en    = bm_string.index(')') - 1
      bm_hash[qry] = bm_string[start..en].to_f
      bm_string = bm_string[(en+2)..-1] #start again from one character after the parentheses
    end
    return bm_hash
  end

  def write_partial(partial, bm_hash)
    f = File.new "./app/views/session/#{partial}", 'w'
    f << "<% @bm_test = #{bm_hash} %>
        <p><em>Winner: #{bm_hash.first.first.titleize}</em></p>
        <dl>
          <% @bm_test.each do |qry| %>
            <dt><%= qry.first.titleize %>:</dt> 
            <dd><%= number_to_human(qry.last) %> seconds</dd>
          <% end %>
        </dl>"
    f.close
  end
end