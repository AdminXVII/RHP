#RHP: the Rust Hypertext Preprocessor

RHP is designed to keep PHP best innovation while permitting the compiled languages speed. Like PHP, RHP has its own set of tags which are written deirectly in HTML code. It is however a preprocessor, as it compiles in obeject code with the help of rust.

## Design
RHP tags are included directly in HTML. However, to enforce the usage of the MVC principle. `<?inc ?>` tags are used to include the controller and <?= ?> tags are used to print variables in the code. Finally, snippets of HTML can be appended to the code with <?snip ?> tags, which allows simpler code and constant look and feel across huge websites.

## Intended user-base
RHP is oriented toward dynamically-generated static webpages. It is not a replacment for Node.js or alike that are intended to provide constant interaction between the server and the user.

# TODO
Adding snippets tags
Adding options
Packaging
Making the paths more robust
