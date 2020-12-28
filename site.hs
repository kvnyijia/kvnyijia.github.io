{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Text.Pandoc.Options        -- For customized Pandoc options

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   $ idRoute
        compile $ copyFileCompiler

    match "css/*" $ do
        route   $ idRoute
        compile $ compressCssCompiler
    
    match "templates/*" $ do 
        compile $ templateBodyCompiler
    
    match "archive/*" $ do
        route   $ setExtension "html"
        compile $ do
            pandocCompilerWith customReaderOptions customWriterOptions
                >>= loadAndApplyTemplate "templates/post.html"    postCtx
                >>= loadAndApplyTemplate "templates/default.html" postCtx
                >>= relativizeUrls

    match "menu/about.md" $ do
        route   $ gsubRoute "menu/" (const "") `composeRoutes` setExtension "html"
        compile $ do 
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
    
    match "menu/archive.md" $ do
        route   $ gsubRoute "menu/" (const "") `composeRoutes` setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll "archive/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    match "menu/home.md" $ do 
        route   $ constRoute "index.html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls

-- Create a context containing $date$ field for posts
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

-- Customize Pandoc options
customReaderOptions = defaultHakyllReaderOptions
    { readerExtensions = extensionsFromList ext_list }

customWriterOptions = defaultHakyllWriterOptions
    { writerExtensions = extensionsFromList ext_list 
    , writerHTMLMathMethod = MathJax defaultMathJaxURL
    }

ext_list = 
    [ Ext_footnotes
    , Ext_inline_notes
    , Ext_pandoc_title_block
    , Ext_yaml_metadata_block
    , Ext_table_captions
    , Ext_implicit_figures
    , Ext_simple_tables
    , Ext_multiline_tables
    , Ext_grid_tables
    , Ext_pipe_tables
    , Ext_citations
    , Ext_emoji
    , Ext_raw_tex
    , Ext_raw_html
    , Ext_tex_math_dollars
    , Ext_tex_math_double_backslash
    , Ext_tex_math_single_backslash
    , Ext_latex_macros
    , Ext_fenced_code_blocks
    , Ext_fenced_code_attributes
    , Ext_backtick_code_blocks
    , Ext_inline_code_attributes
    , Ext_raw_attribute
    , Ext_markdown_in_html_blocks
    , Ext_native_divs
    , Ext_fenced_divs
    , Ext_native_spans
    , Ext_bracketed_spans
    , Ext_escaped_line_breaks
    , Ext_fancy_lists
    , Ext_startnum
    , Ext_definition_lists
    , Ext_example_lists
    , Ext_all_symbols_escapable
    , Ext_intraword_underscores
    , Ext_blank_before_blockquote
    , Ext_blank_before_header
    , Ext_space_in_atx_header
    , Ext_strikeout
    , Ext_superscript
    , Ext_subscript
    , Ext_task_lists
    , Ext_auto_identifiers
    , Ext_header_attributes
    , Ext_link_attributes
    , Ext_implicit_header_references
    , Ext_line_blocks
    , Ext_shortcut_reference_links
    , Ext_smart
    ]