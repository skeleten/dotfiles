 // Failed to get sources. Instead, stub sources have been generated by the disassembler.
 // Implementation of methods is unavailable.
package java.io;
public class PrintStream extends java.io.FilterOutputStream implements java.lang.Appendable, java.io.Closeable {
  
  private final boolean autoFlush;
  
  private boolean trouble;
  
  private java.util.Formatter formatter;
  
  private java.io.BufferedWriter textOut;
  
  private java.io.OutputStreamWriter charOut;
  
  private boolean closing;
  
  private static <T> T requireNonNull(T arg0, java.lang.String arg1) {
    return null;
  }
  
  private static java.nio.charset.Charset toCharset(java.lang.String arg0) throws java.io.UnsupportedEncodingException {
    return null;
  }
  
  private PrintStream(boolean arg0, java.io.OutputStream arg1) {
  }
  
  private PrintStream(boolean arg0, java.io.OutputStream arg1, java.nio.charset.Charset arg2) {
  }
  
  private PrintStream(boolean arg0, java.nio.charset.Charset arg1, java.io.OutputStream arg2) throws java.io.UnsupportedEncodingException {
  }
  
  public PrintStream(java.io.OutputStream arg0) {
  }
  
  public PrintStream(java.io.OutputStream arg0, boolean arg1) {
  }
  
  public PrintStream(java.io.OutputStream arg0, boolean arg1, java.lang.String arg2) throws java.io.UnsupportedEncodingException {
  }
  
  public PrintStream(java.lang.String arg0) throws java.io.FileNotFoundException {
  }
  
  public PrintStream(java.lang.String arg0, java.lang.String arg1) throws java.io.FileNotFoundException, java.io.UnsupportedEncodingException {
  }
  
  public PrintStream(java.io.File arg0) throws java.io.FileNotFoundException {
  }
  
  public PrintStream(java.io.File arg0, java.lang.String arg1) throws java.io.FileNotFoundException, java.io.UnsupportedEncodingException {
  }
  
  private void ensureOpen() throws java.io.IOException {
  }
  
  public void flush() {
  }
  
  public void close() {
  }
  
  public boolean checkError() {
    return false;
  }
  
  protected void setError() {
  }
  
  protected void clearError() {
  }
  
  public void write(int arg0) {
  }
  
  public void write(byte[] arg0, int arg1, int arg2) {
  }
  
  private void write(char[] arg0) {
  }
  
  private void write(java.lang.String arg0) {
  }
  
  private void newLine() {
  }
  
  public void print(boolean arg0) {
  }
  
  public void print(char arg0) {
  }
  
  public void print(int arg0) {
  }
  
  public void print(long arg0) {
  }
  
  public void print(float arg0) {
  }
  
  public void print(double arg0) {
  }
  
  public void print(char[] arg0) {
  }
  
  public void print(java.lang.String arg0) {
  }
  
  public void print(java.lang.Object arg0) {
  }
  
  public void println() {
  }
  
  public void println(boolean arg0) {
  }
  
  public void println(char arg0) {
  }
  
  public void println(int arg0) {
  }
  
  public void println(long arg0) {
  }
  
  public void println(float arg0) {
  }
  
  public void println(double arg0) {
  }
  
  public void println(char[] arg0) {
  }
  
  public void println(java.lang.String arg0) {
  }
  
  public void println(java.lang.Object arg0) {
  }
  
  public java.io.PrintStream printf(java.lang.String arg0, java.lang.Object... arg1) {
    return null;
  }
  
  public java.io.PrintStream printf(java.util.Locale arg0, java.lang.String arg1, java.lang.Object... arg2) {
    return null;
  }
  
  public java.io.PrintStream format(java.lang.String arg0, java.lang.Object... arg1) {
    return null;
  }
  
  public java.io.PrintStream format(java.util.Locale arg0, java.lang.String arg1, java.lang.Object... arg2) {
    return null;
  }
  
  public java.io.PrintStream append(java.lang.CharSequence arg0) {
    return null;
  }
  
  public java.io.PrintStream append(java.lang.CharSequence arg0, int arg1, int arg2) {
    return null;
  }
  
  public java.io.PrintStream append(char arg0) {
    return null;
  }
  
  public bridge java.lang.Appendable append(char arg0) throws java.io.IOException {
    return null;
  }
  
  public bridge java.lang.Appendable append(java.lang.CharSequence arg0, int arg1, int arg2) throws java.io.IOException {
    return null;
  }
  
  public bridge java.lang.Appendable append(java.lang.CharSequence arg0) throws java.io.IOException {
    return null;
  }
}