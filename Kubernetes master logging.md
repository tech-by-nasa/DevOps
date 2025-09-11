## Logging
## Logging Formats

Kubernetes supports multiple logging formats to allow users flexibility in picking a format that best matches their needs.
As new features and logging formats are proposed, we expect that the Kubernetes community might find itself in disagreement about what formats and features should be officially supported.
This section will serve as a developer documentation describing high level goals of each format, giving a holistic vision of logging options and allowing the community to resolve any future disagreement when making changes.

### Text logging format

* Default format in Kubernetes.
* Purpose:
  * Maintain backward compatibility with klog format.
  * Human-readable
  * Development
* Features:
  * Minimal support for structured metadata - required to maintain backward compatibility.
  * Marshals object using fmt.Stringer interface allowing to provide a human-readable reference. For example `pod="kube-system/kube-dns"`.
  * Support for multi-line strings with actual line breaks - allows dumping whole yaml objects for debugging.

Logs written using text format will always have standard header, however message format differ based on whether string formatting (Infof, Errorf, ...) or structured logging method was used to call klog (InfoS, ErrorS).

Examples, first written using Infof, in second InfoS was used.
```
I0528 19:15:22.737538   47512 logtest.go:52] Pod kube-system/kube-dns status was updated to ready
I0528 19:15:22.737538   47512 logtest.go:52] "Pod status was updated" pod="kube-system/kube-dns" status="ready"
```
Explanation of header:
```
Lmmdd hh:mm:ss.uuuuuu threadid file:line] msg...

where the fields are defined as follows:
	L                A single character, representing the log level (eg 'I' for INFO)
	mm               The month (zero padded; ie May is '05')
	dd               The day (zero padded)
	hh:mm:ss.uuuuuu  Time in hours, minutes and fractional seconds
	threadid         The space-padded thread ID as returned by GetTID()
	file             The file name
	line             The line number
	msg              The user-supplied message
```

See more in [here](https://github.com/kubernetes/klog/blob

### JSON logging format

* Requires passing `--logging-format=json` to enable
* Purpose:
  * Provide structured metadata in efficient way.
  * Optimized for efficient log consumption, processing and querying.
  * Machine-readable
* Feature:
  * Full support for structured metadata, using `logr.MarshalLog` when available.
  * Multi-line strings are quoted to fit into a single output line.

Example:
```json
{"ts": 1580306777.04728,"v": 4,"msg": "Pod status was updated","pod":{"name": "kube-dns","namespace": "kube-system"},"status": "ready"}
```

Keys with special meaning:
* ts - timestamp as Unix time (required, float)
* v - verbosity (only for info and not for error messages, int)
* err - error string (optional, string)
* msg - message (required, string)
