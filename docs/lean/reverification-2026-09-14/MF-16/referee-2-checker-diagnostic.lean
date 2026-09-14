import NLA.MF16.Definitions
open NLA.MF16 LeanCert.Core LeanCert.Engine
-- Diagnostic computation only, not a proof theorem.
#eval krawczykCheck polynomialSystem rootBox rootCertificate {}
#eval rootCertificate.preconditioner.det
#eval boxRadius rootBox rootCenter
#eval contractionBound
