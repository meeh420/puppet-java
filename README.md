# Java Puppet Module
This module manages Oracle/OpenJDK Java.

Supported Java versions: 6, 7 and 8 from Oracle and OpenJDK 6/7.

This module has been tested against puppet 3.4 on Ubuntu 12.04 and Debian 6/7. (It currently support only Debian and Ubuntu as well.)

Pull requests to add support for other operating systems are welcome.

*NOTE:* This mode may only be used if you choose OpenJDK or you agree to the Oracle license: http://www.oracle.com/technetwork/java/javase/terms/license/

### Usage

    # It defaults to Oracle Java 8

    # Common
    include java

    # OracleJDK
    class {'java': $java_version => '8', $install_oracle_java = true }

    # OpenJDK
    class {'java': $java_version => '7', $install_oracle_java = false }


### Improvements since fork
* Support for multiple versions.
* Support for both Oracle and OpenJDK.

### Author
* Mikal Villa <meeh@sigterm.no>

### Contributors:
* Scott Smerchek <scott.smerchek@softekinc.com>: wrote the original Java7 module
* flosell: Added Debian 6 support


### Donate

*BTC:* 1MeehoFybzJ41Yv88VMRqXSa2T9TpGfPhR
*ANC/XPM:* AMeehr1AtpyMaZKVLv4Tb1wdRtVfx3wDj3
*LTC:* LMeehUw9NgheMbNdaGPaz3m5MVuQpJeagX
*PPC:* PMeehToGoSPVSzfq1SnH4npoRUQyqKDRsM


