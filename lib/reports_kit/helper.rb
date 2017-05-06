module ReportsKit
  module Helper
    def render_report(properties, &block)
      if properties.is_a?(String)
        path = Rails.root.join('config', 'reports_kit', 'reports', "#{properties}.yml")
        properties = YAML.load_file(path)
      end
      builder = ReportsKit::ReportBuilder.new(properties)
      content_tag :div, nil, class: 'reports_kit_report', data: { properties: builder.properties, path: reports_kit_path } do
        if block_given?
          form_tag reports_kit_path, method: 'get', class: 'reports_kit_report_form form-inline' do
            capture(builder, &block)
          end
        end
      end
    end
  end
end