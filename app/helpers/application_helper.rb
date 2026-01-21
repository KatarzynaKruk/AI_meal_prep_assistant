module ApplicationHelper
  require "redcarpet"

def render_markdown(text)
  return "" if text.blank?
  renderer = Redcarpet::Render::HTML.new(
    filter_html: true,    # Strip unsafe HTML tags
    escape_html: true     # Escape untrusted input
  )
  markdown = Redcarpet::Markdown.new(renderer, {
    autolink: true,           # Auto-link URLs
    tables: true,             # Render tables
    fenced_code_blocks: true, # Syntax-highlighted code
    strikethrough: true,
    superscript: true
  })
  sanitize(markdown.render(text))  # Rails sanitize for extra XSS protection
end


end
